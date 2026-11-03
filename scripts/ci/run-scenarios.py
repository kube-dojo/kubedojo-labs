"""Host driver. Scenario code runs only in fresh disposable containers or kind clusters."""
import argparse
from contextlib import contextmanager
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import time
import uuid

from scenarios import REFERENCES, requirements, step_files, steps_for, validate

ROOT = Path(__file__).resolve().parents[2]
UBUNTU_IMAGE = "kubedojo-ubuntu:ci"
K8S_IMAGE = "kubedojo-kind:ci"


class InfrastructureError(RuntimeError):
    pass


class ScenarioTimeout(BaseException):
    """Escape per-lane error handling so a scenario cannot overrun its wall clock."""


def command(argv, timeout=120, check=True):
    try:
        result = subprocess.run(argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                text=True, timeout=timeout)
    except subprocess.TimeoutExpired as exc:
        raise InfrastructureError(f"timeout ({timeout}s): {argv[0:3]}") from exc
    if check and result.returncode:
        raise InfrastructureError(f"command exited {result.returncode}: {argv[0:3]}\n{result.stdout[-4000:]}")
    return result


def build(backend):
    image = UBUNTU_IMAGE if backend == "ubuntu" else K8S_IMAGE
    dockerfile = "Dockerfile.ubuntu-harness" if backend == "ubuntu" else "Dockerfile.kind-harness"
    command(["docker", "build", "-t", image, "-f", str(ROOT / "scripts/ci" / dockerfile),
             str(ROOT / "scripts/ci")], timeout=300)


@contextmanager
def fresh_environment(scenario, backend):
    """Unique cluster per lane; never reattach to an existing cluster or reuse a namespace."""
    name = "kd-" + uuid.uuid4().hex[:16]
    node = name if backend == "ubuntu" else name + "-control-plane"
    try:
        if backend == "ubuntu":
            command(["docker", "run", "-d", "--name", node, "--privileged", "--cgroupns=private",
                     "--tmpfs", "/run", "--tmpfs", "/run/lock", "--tmpfs", "/tmp",
                     UBUNTU_IMAGE])
            for _ in range(45):
                state = command(["docker", "exec", node, "systemctl", "is-system-running"],
                                timeout=5, check=False).stdout.strip()
                if state in {"running", "degraded"}:
                    break
                time.sleep(1)
            else:
                raise InfrastructureError("systemd did not boot within 45s")
        else:
            command(["kind", "create", "cluster", "--name", name, "--image", K8S_IMAGE,
                     "--wait", "90s"], timeout=180)
        command(["docker", "exec", node, "mkdir", "-p", "/scenario", "/opt/harness"])
        command(["docker", "cp", str(scenario) + "/.", node + ":/scenario/"])
        for file in ("scenarios.py", "run-steps.py"):
            command(["docker", "cp", str(ROOT / "scripts/ci" / file), node + ":/opt/harness/" + file])
        yield node
    finally:
        # Runs after a setup, command, transcript, verifier or host-driver failure.
        if backend == "ubuntu":
            cleanup = command(["docker", "rm", "-f", node], timeout=30, check=False)
        else:
            cleanup = command(["kind", "delete", "cluster", "--name", name], timeout=45, check=False)
        if cleanup.returncode:
            raise InfrastructureError(f"cleanup failed for {name}: {cleanup.stdout[-2000:]}")


def execute(scenario, backend, mode, target=None, fixture=None):
    with fresh_environment(scenario, backend) as node:
        argv = ["docker", "exec", "-e", "KUBECONFIG=/etc/kubernetes/admin.conf", node,
                "python3", "/opt/harness/run-steps.py", "--mode", mode, "--timeout", "120"]
        if target is not None:
            argv += ["--target", str(target), "--fixture", "/scenario/" + str(fixture.relative_to(scenario))]
        process = command(argv, timeout=600, check=False)
        if process.returncode not in (0, 1):
            raise InfrastructureError(f"guest crashed with {process.returncode}: {process.stdout[-4000:]}")
        # docker cp uses the archive API, which cannot read user-mounted tmpfs.
        # Read exactly the designated report through exec, not the lab's stdout.
        try:
            data = command(["docker", "exec", node, "cat", "/tmp/lane-report.json"])
        except InfrastructureError as exc:
            raise InfrastructureError(f"{exc}\nGuest exit {process.returncode}: {process.stdout[-6000:]}") from exc
        result = json.loads(data.stdout)
        if process.returncode == 1:
            result["status"] = "fail"
        return result


def run_scenario(scenario, executor=execute):
    reference = scenario.name in REFERENCES
    index, steps = validate(scenario, reference)
    backend = index["backend"]["imageid"]
    report = {"scenario": scenario.name, "level": "executable" if reference else "residual",
              "certification": "D1 evidence only; native D2 walkthrough still required" if reference else "not certified",
              "steps": [{"step": n + 1, "text": step["text"], "class": step.get("class"),
                         "transcript": "not run" if reference else "not replayable",
                         "solution": "not run", "fixtures": [],
                         "adequacy": "not run" if reference else "checker adequacy not proven"}
                        for n, step in enumerate(steps)], "runs": []}
    modes = ("learner", "solution") if reference else ("residual",)
    for mode in modes:
        try:
            result = executor(scenario, backend, mode)
        except Exception as exc:
            result = {"mode": mode, "status": "fail", "error": f"crash or timeout: {exc}"}
        report["runs"].append(result)
        for row in result.get("steps", []):
            report["steps"][row["step"] - 1]["transcript" if mode == "learner" else "solution"] = row
    if reference:
        for target, step in enumerate(steps):
            if step["class"] == "info" or (step["class"] == "observe" and "verify" not in step):
                report["steps"][target]["adequacy"] = "not applicable"
                continue
            data = requirements(scenario, step)
            for row in data["requirements"]:
                _, path = step_files(scenario, step)
                fixture = path.parent / row["negative"]
                try:
                    result = executor(scenario, backend, "negative", target, fixture)
                except Exception as exc:
                    result = {"mode": "negative", "status": "fail", "error": f"crash or timeout: {exc}"}
                result.update(requirement=row["id"], outcome=row["outcome"], step=target + 1)
                report["runs"].append(result)
                report["steps"][target]["fixtures"].append(result)
            report["steps"][target]["adequacy"] = (
                "pass" if all(r["status"] == "pass" for r in report["steps"][target]["fixtures"])
                else "checker adequacy not proven")
    report["execution"] = "pass" if all(r["status"] == "pass" for r in report["runs"]) else "fail"
    return report


def exit_status(report, event, touched=True):
    return int(report["execution"] != "pass" and
               (report["level"] == "executable" or (event == "pull_request" and touched)))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("scenarios", nargs="*")
    parser.add_argument("--all", action="store_true")
    parser.add_argument("--backend", choices=["ubuntu", "kubernetes-kubeadm-1node"])
    parser.add_argument("--event", choices=["pull_request", "push", "schedule", "local"], default="local")
    parser.add_argument("--touched", choices=["true", "false"], default="true")
    parser.add_argument("--report-dir", type=Path, default=Path("reports"))
    args = parser.parse_args()
    names = args.scenarios
    if args.all:
        names = sorted(p.parent.name for p in ROOT.glob("*/index.json") if p.parent.name != "templates")
    if not names:
        parser.error("select at least one scenario or --all")
    built, failed = set(), False
    args.report_dir.mkdir(parents=True, exist_ok=True)
    # Raising on TERM preserves the finally cleanup during the scenario time limit.
    def interrupted(signum, frame):
        raise ScenarioTimeout(f"scenario interrupted by signal {signum}")
    signal.signal(signal.SIGTERM, interrupted)
    signal.signal(signal.SIGALRM, interrupted)
    for name in names:
        if Path(name).name != name:
            parser.error("scenario must be a repository directory name")
        path = ROOT / name
        started = time.monotonic()
        report = {"scenario": name, "level": "executable" if name in REFERENCES else "residual",
                  "execution": "fail", "steps": [], "runs": []}
        try:
            signal.alarm(1020)
            index, _ = validate(path, name in REFERENCES)
            _, steps = steps_for(path)
            report["steps"] = [{"step": n + 1, "text": step["text"],
                                "transcript": "not run" if name in REFERENCES else "not replayable",
                                "solution": "not run", "fixtures": [],
                                "adequacy": "checker adequacy not proven"}
                               for n, step in enumerate(steps)]
            backend = index["backend"]["imageid"]
            if args.backend and backend != args.backend:
                continue
            if backend not in built:
                build(backend)
                built.add(backend)
            # One-lab execution is capped at 17 minutes, including the image build.
            report = run_scenario(path)
        except (Exception, ScenarioTimeout) as exc:
            report["error"] = f"crash, missing input or timeout: {type(exc).__name__}: {exc}"
        finally:
            signal.alarm(0)
        report["elapsed_seconds"] = round(time.monotonic() - started, 3)
        report["disposition"] = ("lane issue required" if report["execution"] == "fail"
                                  and report["level"] == "residual" and not (
                                      args.event == "pull_request" and args.touched == "true")
                                  else report["execution"])
        (args.report_dir / (name + ".json")).write_text(json.dumps(report, indent=2) + "\n")
        print(json.dumps({k: report[k] for k in ("scenario", "level", "execution", "disposition", "elapsed_seconds")}), flush=True)
        failed |= exit_status(report, args.event, args.touched == "true") != 0
    return int(failed)


if __name__ == "__main__":
    raise SystemExit(main())
