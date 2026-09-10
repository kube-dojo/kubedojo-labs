"""Step driver for one scenario lane. Runs inside the harness container.

For each step (in index.json order):
  1. Apply the canonical solution as the lane user:
       index.json "solution" -> stepN/solution.sh on disk -> bash blocks
       inside <details> hints in text.md (legacy beginner scenarios only).
  2. Run verify.sh (as root, with HOME/USER of the lane user — same
     contract Killercoda and the previous harness used).

Exits non-zero on the first failing step. No step is ever skipped: a step
without any solution source still runs verify, so a scenario cannot pass
by omitting its solution.
"""
import json
import os
import re
import subprocess
import sys
import tempfile

TEST_USER = os.environ["TEST_USER"]
USER_HOME = os.path.expanduser(f"~{TEST_USER}")
SCRIPT_TIMEOUT = int(os.environ.get("STEP_TIMEOUT", "120"))


def run_script(argv: list[str], env: dict | None = None) -> tuple[int, str]:
    """Run a solution/verify script with output to a FILE, not a pipe.

    Scenarios legitimately leave background processes running (CPU hogs,
    daemons). With pipes, subprocess.run() would block until those
    grandchildren exit; with a file it returns as soon as the script does.
    A UNIQUE file per invocation: background survivors inherit the fd, and
    reusing one path would truncate under them and interleave their output
    into later steps' logs.
    """
    with tempfile.NamedTemporaryFile(
        mode="w+", prefix="step-out-", suffix=".txt", delete=False,
    ) as out:
        try:
            proc = subprocess.run(
                argv, stdout=out, stderr=out, env=env, timeout=SCRIPT_TIMEOUT,
            )
            rc = proc.returncode
        except subprocess.TimeoutExpired:
            rc = 124
        out.seek(0)
        return rc, out.read()

with open("/scenario/index.json") as f:
    index = json.load(f)

steps = index["details"]["steps"]

def solution_script(step_num: int, step: dict) -> str | None:
    """Return a path to an executable solution script, or None."""
    declared = step.get("solution")
    if declared and os.path.exists(f"/scenario/{declared}"):
        return f"/scenario/{declared}"
    on_disk = f"/scenario/step{step_num}/solution.sh"
    if os.path.exists(on_disk):
        return on_disk
    # Legacy fallback: beginner scenarios embed complete commands in
    # <details> hint blocks instead of shipping solution.sh.
    text_path = f"/scenario/step{step_num}/text.md"
    if os.path.exists(text_path):
        with open(text_path) as fh:
            content = fh.read()
        blocks = []
        for d in re.findall(r"<details>.*?</details>", content, re.DOTALL):
            blocks.extend(re.findall(r"```bash\n(.*?)\n```", d, re.DOTALL))
        if blocks:
            path = f"/tmp/hint_step{step_num}.sh"
            with open(path, "w") as fh:
                fh.write("#!/bin/bash\n" + "\n".join(blocks) + "\n")
            return path
    return None

failed = False
for i, step in enumerate(steps, 1):
    script = solution_script(i, step)
    if script:
        rc, output = run_script(["su", "-", TEST_USER, "-c", f"bash {script}"])
        if rc != 0:
            what = "timed out" if rc == 124 else f"exited {rc}"
            print(f"      [WARN] solution for step {i} {what}: "
                  f"{output.strip()[-200:]}")
    else:
        print(f"      [WARN] no solution source for step {i}; "
              f"running verify against setup state only")

    verify = step.get("verify", f"step{i}/verify.sh")
    verify_path = f"/scenario/{verify}"
    if not os.path.exists(verify_path):
        print(f"      FAIL step {i}")
        print(f"      REASON: declared verify script {verify} is missing")
        failed = True
        break
    rc, output = run_script(
        ["bash", verify_path],
        env={**os.environ, "HOME": USER_HOME, "USER": TEST_USER},
    )
    if rc != 0:
        print(f"      FAIL step {i}")
        reason = "verify timed out" if rc == 124 else output.strip()
        print(f"      REASON: {reason[:500]}")
        failed = True
        break
    print(f"      PASS step {i}")

if failed:
    sys.exit(1)
print("  ALL STEPS PASSED")
