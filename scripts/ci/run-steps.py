"""Run one lane inside a disposable lab environment, in manifest order."""
import argparse
import json
import os
from pathlib import Path
import pwd
import re
import shlex
import signal
import subprocess
import tempfile
import time

from scenarios import requirements, solution_path, step_files, validate


class Failure(RuntimeError):
    pass


def transcript(path):
    """Annotations precede a shell chunk. A chunk can include a heredoc."""
    chunks, lines, expected, patterns = [], [], 0, []
    def flush():
        if any(line.strip() and not line.lstrip().startswith("#") for line in lines):
            chunks.append(("\n".join(lines) + "\n", expected, list(patterns)))
    for line in path.read_text().splitlines():
        if line.startswith("# expect-exit:"):
            flush()
            lines, patterns = [], []
            expected = int(line.split(":", 1)[1].strip())
            if not 0 <= expected <= 255:
                raise Failure(f"invalid expected exit: {path}")
        elif line.startswith("# expect-output:"):
            pattern = line.split(":", 1)[1].strip()
            re.compile(pattern)
            patterns.append(pattern)
        else:
            lines.append(line)
    flush()
    if not chunks:
        raise Failure(f"not replayable: empty transcript {path}")
    return chunks


class Shell:
    """One terminal across commands and steps, preserving cd and shell variables."""
    def __init__(self, user, home, timeout):
        self.timeout = timeout
        self.directory = tempfile.TemporaryDirectory(prefix="learner-")
        self.root = Path(self.directory.name)
        self.root.chmod(0o777)
        argv = ["bash", "--noprofile", "--norc"]
        if user != pwd.getpwuid(os.geteuid()).pw_name:
            argv = ["sudo", "-H", "-u", user, *argv]
        self.process = subprocess.Popen(argv, stdin=subprocess.PIPE,
                                        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                                        cwd=home, env={**os.environ, "HOME": home, "USER": user},
                                        text=True, start_new_session=True)
        self.number = 0

    def run(self, code, expected=0, patterns=()):
        self.number += 1
        source = self.root / f"{self.number}.sh"
        output = self.root / f"{self.number}.out"
        status = self.root / f"{self.number}.status"
        source.write_text(code)
        source.chmod(0o644)
        # errexit runs at top level, not masked by an if/function wrapper.
        command = (f"set {'-e' if expected == 0 else '+e'}\n"
                   f"source {shlex.quote(str(source))} >{shlex.quote(str(output))} 2>&1\n"
                   f"printf '%s' \"$?\" >{shlex.quote(str(status))}.tmp\n"
                   f"mv {shlex.quote(str(status))}.tmp {shlex.quote(str(status))}\n")
        try:
            self.process.stdin.write(command)
            self.process.stdin.flush()
        except BrokenPipeError as exc:
            raise Failure("learner shell crashed") from exc
        deadline = time.monotonic() + self.timeout
        while not status.exists():
            if self.process.poll() is not None:
                detail = output.read_text(errors="replace") if output.exists() else ""
                raise Failure(f"learner shell crashed/exited {self.process.returncode}: {detail[-2000:]}")
            if time.monotonic() >= deadline:
                raise Failure(f"timeout: learner command after {self.timeout}s")
            time.sleep(0.02)
        actual = int(status.read_text())
        detail = output.read_text(errors="replace")
        if actual != expected:
            raise Failure(f"wrong expected exit: expected {expected}, got {actual}: {detail[-2000:]}")
        for pattern in patterns:
            if not re.search(pattern, detail, re.MULTILINE):
                raise Failure(f"unmatched expected output {pattern!r}: {detail[-2000:]}")
        return {"exit": actual, "expected": expected, "output": detail[-4000:], "patterns": patterns}

    def close(self):
        if self.process.poll() is None:
            os.killpg(self.process.pid, signal.SIGKILL)
        self.process.wait()
        self.process.stdin.close()
        self.directory.cleanup()


def run_script(path, home, timeout, user=None):
    user = user or pwd.getpwuid(os.geteuid()).pw_name
    argv = ["bash", "-e", str(path)]
    if user != pwd.getpwuid(os.geteuid()).pw_name:
        argv = ["sudo", "-H", "-u", user, *argv]
    with tempfile.TemporaryFile(mode="w+") as output:
        process = subprocess.Popen(argv, stdout=output, stderr=output, cwd=home,
                                   env={**os.environ, "HOME": home, "USER": user},
                                   start_new_session=True)
        try:
            code = process.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            os.killpg(process.pid, signal.SIGKILL)
            process.wait()
            raise Failure(f"timeout: {path} after {timeout}s")
        output.seek(0)
        detail = output.read()[-4000:]
    return code, detail


def check_verify(root, step, home, timeout, expected):
    if "verify" not in step:
        raise Failure(f"missing class-required verify: {step['text']}")
    code, output = run_script(root / step["verify"], home, timeout)
    # Exit 1 is a negative result. Other statuses are crashes, not adequacy proof.
    if code != expected:
        raise Failure(f"verify expected {expected}, got {code}: {output}")
    return {"exit": code, "output": output}


def run_lane(root, mode, target=None, fixture=None, timeout=60, identity=None):
    reference = mode != "residual"
    index, steps = validate(root, reference)
    if mode == "negative":
        if target is None or not 0 <= target < len(steps) or fixture is None:
            raise Failure("missing or invalid negative target/fixture")
        _, map_path = step_files(root, steps[target])
        allowed = {(map_path.parent / row["negative"]).resolve()
                   for row in requirements(root, steps[target])["requirements"]}
        if fixture.resolve() not in allowed:
            raise Failure("negative fixture is not in the requirement map")
    user = "root"
    if index["backend"]["imageid"] == "ubuntu":
        try:
            pwd.getpwnam("ubuntu")
            user = "ubuntu"
        except KeyError:
            pass
    home = pwd.getpwnam(user).pw_dir
    if identity is not None:
        user, home = identity
    shell = Shell(user, home, timeout)
    result = {"mode": mode, "status": "fail", "steps": []}
    try:
        setup = index["details"].get("intro", {}).get("background")
        if setup:
            code, output = run_script(root / setup, home, timeout)
            result["setup"] = {"exit": code, "output": output}
            if code:
                raise Failure(f"setup failed with {code}: {output}")
        for number, step in enumerate(steps):
            row = {"step": number + 1, "text": step["text"], "status": "not run"}
            result["steps"].append(row)
            cls = step.get("class") if reference else None
            if cls == "info":
                row["status"] = "info, nothing executed"
                continue
            try:
                negative = mode == "negative" and number == target
                learner_run = mode in {"learner", "negative"} and not negative
                if negative:
                    if fixture is None:
                        raise Failure("missing negative fixture")
                    code, output = run_script(fixture, home, timeout, user)
                    row["fixture"] = {"exit": code, "output": output}
                    if code:
                        raise Failure(f"fixture crashed with {code}: {output}")
                    row["verify"] = check_verify(root, step, home, timeout, 1)
                    row["status"] = "pass"
                    break
                if reference and "verify" in step:
                    reason = requirements(root, step).get("initial_pass")
                    code, output = run_script(root / step["verify"], home, timeout)
                    row["initial"] = {"exit": code, "reason": reason, "output": output}
                    if cls == "delete" and code != 1:
                        raise Failure("delete target not present or verify crashed before transcript")
                    if code not in (0, 1):
                        raise Failure(f"initial verify crashed with {code}: {output}")
                    if code == 0 and not reason:
                        raise Failure("verify already passes without initial_pass reason")
                if learner_run:
                    path, _ = step_files(root, step)
                    chunks = transcript(path)
                    if cls == "observe" and not all(patterns for _, _, patterns in chunks):
                        raise Failure("observe command missing expected output")
                    if cls == "expect-error" and not any(expected for _, expected, _ in chunks):
                        raise Failure("expect-error transcript has no expected nonzero status")
                    row["transcript"] = [shell.run(code, expected, patterns)
                                         for code, expected, patterns in chunks]
                else:
                    path = solution_path(root, step)
                    code, output = run_script(path, home, timeout, user)
                    row["solution"] = {"exit": code, "output": output}
                    if code:
                        raise Failure(f"solution failed with {code}: {output}")
                if "verify" in step:
                    row["verify"] = check_verify(root, step, home, timeout, 0)
                elif not reference:
                    raise Failure(f"missing declared verify: {step['text']}")
                row["status"] = "pass"
            except (Failure, ValueError, OSError) as exc:
                row.update(status="fail", error=str(exc))
                raise
        result["status"] = "pass"
    except (Failure, ValueError, OSError) as exc:
        result["error"] = str(exc)
    finally:
        shell.close()
        for number in range(len(result["steps"]), len(steps)):
            result["steps"].append({"step": number + 1, "text": steps[number]["text"], "status": "not run"})
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, default=Path("/scenario"))
    parser.add_argument("--mode", choices=["learner", "solution", "negative", "residual"], required=True)
    parser.add_argument("--target", type=int)
    parser.add_argument("--fixture", type=Path)
    parser.add_argument("--timeout", type=int, default=60)
    parser.add_argument("--report", type=Path, default=Path("/tmp/lane-report.json"))
    args = parser.parse_args()
    try:
        result = run_lane(args.root, args.mode, args.target, args.fixture, args.timeout)
    except Exception as exc:
        result = {"mode": args.mode, "status": "fail", "error": f"crash: {type(exc).__name__}: {exc}"}
    args.report.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result), flush=True)
    return int(result["status"] != "pass")


if __name__ == "__main__":
    raise SystemExit(main())
