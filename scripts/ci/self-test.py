"""AC-02 regression tests use real shell exit/output and disposable fixture trees.

The cluster lifecycle unit test substitutes the CLI transport only. --live-kind
additionally proves isolation using a real cluster-scoped object on two fresh clusters.
"""
import importlib.util
from contextlib import contextmanager
import json
import os
from pathlib import Path
import pwd
import shutil
import subprocess
import sys
import tempfile
import textwrap
import unittest
from unittest.mock import patch

from scenarios import select, validate
import scenarios


def module(name):
    spec = importlib.util.spec_from_file_location(name.replace("-", "_"), Path(__file__).with_name(name + ".py"))
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


guest = module("run-steps")
host = module("run-scenarios")


class FalseGreenTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary.name)
        self.step = self.make_step("step1")
        self.identity = (pwd.getpwuid(os.geteuid()).pw_name, str(self.root))
        self.manifest([self.step])

    def tearDown(self):
        self.temporary.cleanup()

    def write(self, name, code):
        file = self.root / name
        file.parent.mkdir(parents=True, exist_ok=True)
        file.write_text(code)
        return file

    def make_step(self, name):
        self.write(name + "/text.md", "Create the done file.")
        self.write(name + "/learner.sh", "# expect-exit: 0\ntouch \"$HOME/done\"\n")
        self.write(name + "/solution.sh", "touch \"$HOME/done\"\n")
        self.write(name + "/verify.sh", '[ -e "$HOME/done" ]\n')
        self.write(name + "/negative/missing.sh", 'rm -f "$HOME/done"\n')
        self.write(name + "/requirements.yaml", json.dumps({"requirements": [{
            "id": "done", "outcome": "done exists", "assertion": "test -e done",
            "negative": "negative/missing.sh"}]}))
        return {"title": name, "text": name + "/text.md", "verify": name + "/verify.sh", "class": "change"}

    def manifest(self, steps):
        self.write("index.json", json.dumps({"title": "fixture", "backend": {"imageid": "kubernetes-kubeadm-1node"},
                                            "details": {"steps": steps}}))

    def lane(self, mode="learner", **kwargs):
        return guest.run_lane(self.root, mode, timeout=2, identity=self.identity, **kwargs)

    def test_always_zero_verify_rejected_by_negative_fixture(self):
        self.write("step1/verify.sh", "exit 0\n")
        result = self.lane("negative", target=0, fixture=self.root / "step1/negative/missing.sh")
        self.assertEqual(result["status"], "fail")
        self.assertIn("verify expected 1, got 0", result["error"])

    def test_failing_solution_is_not_a_warning(self):
        self.write("step1/solution.sh", 'touch "$HOME/done"\nexit 9\n')
        result = self.lane("solution")
        self.assertEqual(result["status"], "fail")
        self.assertIn("solution failed with 9", result["error"])

    def test_missing_class_required_verify_rejected(self):
        del self.step["verify"]
        self.manifest([self.step])
        with self.assertRaisesRegex(ValueError, "missing class-required verify"):
            validate(self.root, True)

    def test_hint_never_overrides_failing_solution(self):
        self.write("step1/text.md", '<details>```bash\ntouch "$HOME/done"\n```</details>')
        self.write("step1/solution.sh", "exit 7\n")
        result = self.lane("solution")
        self.assertEqual(result["status"], "fail")
        self.assertIn("solution failed with 7", result["error"])

    def test_manifest_order_overrides_sorted_directory_order(self):
        first = self.make_step("step2")
        self.write("step2/learner.sh", 'mkdir "$HOME/state"\ncd "$HOME/state"\nTOKEN=kept\n')
        self.write("step2/verify.sh", '[ -d "$HOME/state" ]\n')
        self.write("step1/learner.sh", '[ "$TOKEN" = kept ]\n[ "$PWD" = "$HOME/state" ]\ntouch "$HOME/done"\n')
        self.manifest([first, self.step])
        result = self.lane()
        self.assertEqual(result["status"], "pass", result)
        self.assertEqual([r["text"] for r in result["steps"]], ["step2/text.md", "step1/text.md"])

    def test_shared_cluster_leakage_prevented_by_unique_create_delete(self):
        created, deleted, live = [], [], set()
        def cli(argv, **kwargs):
            if argv[:3] == ["kind", "create", "cluster"]:
                name = argv[argv.index("--name") + 1]
                self.assertNotIn(name, created)
                created.append(name)
                live.add(name)
            elif argv[:3] == ["kind", "delete", "cluster"]:
                name = argv[argv.index("--name") + 1]
                deleted.append(name)
                live.discard(name)
            return type("Result", (), {"returncode": 0, "stdout": ""})()
        with patch.object(host, "command", side_effect=cli):
            with host.fresh_environment(self.root, "kubernetes-kubeadm-1node"):
                self.assertEqual(len(live), 1)
            with self.assertRaisesRegex(RuntimeError, "intentional crash"):
                with host.fresh_environment(self.root, "kubernetes-kubeadm-1node"):
                    raise RuntimeError("intentional crash")
        self.assertEqual(len(created), 2)
        self.assertEqual(deleted, created)
        self.assertEqual(live, set())

    def test_report_collection_reads_mounted_tmpfs_through_exec(self):
        @contextmanager
        def environment(*args):
            yield "test-node"
        def cli(argv, **kwargs):
            if argv[:2] == ["docker", "cp"]:
                raise host.InfrastructureError("archive API cannot read tmpfs")
            if argv == ["docker", "exec", "test-node", "cat", "/tmp/lane-report.json"]:
                output = '{"status":"pass","steps":[]}'
            else:
                output = "lab stdout is not the report"
            return type("Result", (), {"returncode": 0, "stdout": output})()
        with patch.object(host, "fresh_environment", environment), patch.object(host, "command", side_effect=cli):
            result = host.execute(self.root, "ubuntu", "learner")
        self.assertEqual(result, {"status": "pass", "steps": []})

    def test_failure_propagates_to_pr_exit_but_main_residual_is_reported(self):
        report = {"execution": "fail", "level": "executable"}
        self.assertEqual(host.exit_status(report, "pull_request"), 1)
        self.assertEqual(host.exit_status(report, "push"), 1)
        report["level"] = "residual"
        self.assertEqual(host.exit_status(report, "local"), 1)
        self.assertEqual(host.exit_status(report, "pull_request"), 1)
        self.assertEqual(host.exit_status(report, "schedule"), 0)
        self.assertEqual(host.exit_status(report, "pull_request", touched=False), 0)

    def test_build_failure_propagates_through_public_cli(self):
        docker = self.write("bin/docker", "#!/bin/bash\nexit 19\n")
        docker.chmod(0o755)
        result = subprocess.run(
            [sys.executable, str(Path(__file__).with_name("run-scenarios.py")),
             "prereq-0.3-first-commands", "--event", "pull_request", "--report-dir", str(self.root / "reports")],
            env={**os.environ, "PATH": str(docker.parent) + os.pathsep + os.environ["PATH"]},
            text=True, capture_output=True, timeout=10)
        self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
        report = json.loads((self.root / "reports/prereq-0.3-first-commands.json").read_text())
        self.assertEqual(report["execution"], "fail")
        self.assertIn("command exited 19", report["error"])
        # A local residual must also fail through the historical K8s wrapper.
        result = subprocess.run(
            ["bash", str(host.ROOT / "scripts/test-k8s-scenario.sh"), "cka-0.1-cluster-setup",
             "--report-dir", str(self.root / "residual-reports")],
            env={**os.environ, "PATH": str(docker.parent) + os.pathsep + os.environ["PATH"]},
            text=True, capture_output=True, timeout=10)
        self.assertEqual(result.returncode, 1, result.stdout + result.stderr)

    def test_fixture_dotdot_cannot_escape_negative_directory(self):
        data = json.loads((self.root / "step1/requirements.yaml").read_text())
        data["requirements"][0]["negative"] = "negative/../solution.sh"
        self.write("step1/requirements.yaml", json.dumps(data))
        with self.assertRaisesRegex(ValueError, "fixture outside negative"):
            validate(self.root, True)

    def test_wrong_expected_exit_is_rejected(self):
        self.write("step1/learner.sh", "# expect-exit: 3\nfalse\n")
        result = self.lane()
        self.assertEqual(result["status"], "fail")
        self.assertIn("expected 3, got 1", result["error"])

    def test_unmatched_expected_output_is_rejected(self):
        self.write("step1/learner.sh", "# expect-output: wanted\necho wrong\n")
        result = self.lane()
        self.assertEqual(result["status"], "fail")
        self.assertIn("unmatched expected output", result["error"])

    def test_crashing_verify_is_not_a_negative_result(self):
        self.write("step1/verify.sh", "exit 2\n")
        result = self.lane("negative", target=0, fixture=self.root / "step1/negative/missing.sh")
        self.assertEqual(result["status"], "fail")
        self.assertIn("verify expected 1, got 2", result["error"])

    def test_missing_solution_cannot_pass_using_setup_state(self):
        (self.root / "step1/solution.sh").unlink()
        with self.assertRaisesRegex(ValueError, "missing or escaping declared path"):
            validate(self.root, True)

    def test_missing_transcript_fails_evidence_without_failing_structural_level(self):
        nested = self.root / "lab"
        nested.mkdir()
        shutil.move(str(self.root / "step1"), nested)
        shutil.move(str(self.root / "index.json"), nested)
        (nested / "step1/learner.sh").unlink()
        with patch.object(scenarios, "REFERENCES", {"lab"}):
            rows = scenarios.inventory(self.root)
        self.assertEqual(rows[0]["structural"], "pass")
        self.assertEqual(rows[0]["evidence"], "fail")
        self.assertIn("not replayable", rows[0]["evidence_error"])

    def test_timeout_cannot_pass(self):
        self.write("step1/learner.sh", "sleep 10\n")
        result = self.lane()
        self.assertEqual(result["status"], "fail")
        self.assertIn("timeout", result["error"])

    def test_success_chunk_cannot_hide_failed_earlier_command(self):
        self.write("step1/learner.sh", 'false\ntouch "$HOME/done"\n')
        result = self.lane()
        self.assertEqual(result["status"], "fail")

    def test_selection_includes_all_for_shared_changes_and_only_touched_lab(self):
        rows = [{"scenario": "a"}, {"scenario": "b"}]
        self.assertEqual(select(rows, ["a/step1/text.md"]), ["a"])
        self.assertEqual(select(rows, ["scripts/ci/run-steps.py"]), ["a", "b"])
        self.assertEqual(select(rows, ["templates/k8s-base/index.json"]), ["a", "b"])
        self.assertEqual(select(rows, None), ["a", "b"])

    def test_fork_gate_runs_and_refuses_skipped_execution(self):
        workflow = (host.ROOT / ".github/workflows/test-scenarios.yml").read_text()
        gate = workflow.split("  gate:\n", 1)[1]
        self.assertIn("    if: always()\n", gate)
        refusal = gate.split("      - name: Refuse fork pull requests explicitly\n", 1)[1].split("      - name:", 1)[0]
        code = textwrap.dedent(refusal.split("        run: |\n", 1)[1])
        for event, head, expected in [("pull_request", "outside/fork", 1),
                                      ("pull_request", "kube-dojo/kubedojo-labs", 0),
                                      ("push", "", 0)]:
            result = subprocess.run(["bash", "-e", "-c", code], capture_output=True,
                                    env={**os.environ, "GITHUB_EVENT_NAME": event,
                                         "GITHUB_REPOSITORY": "kube-dojo/kubedojo-labs", "HEAD_REPO": head})
            self.assertEqual(result.returncode, expected)


def live_kind_isolation():
    """A cluster-scoped namespace survives namespace-only cleanup, but not fresh clusters."""
    scenario = host.ROOT / "prereq-k8s-1.1-first-cluster"
    with host.fresh_environment(scenario, "kubernetes-kubeadm-1node") as node:
        host.command(["docker", "exec", "-e", "KUBECONFIG=/etc/kubernetes/admin.conf", node,
                      "kubectl", "create", "namespace", "must-not-leak"])
    with host.fresh_environment(scenario, "kubernetes-kubeadm-1node") as node:
        result = host.command(["docker", "exec", "-e", "KUBECONFIG=/etc/kubernetes/admin.conf", node,
                               "kubectl", "get", "namespace", "must-not-leak"], check=False)
        if result.returncode != 1 or "NotFound" not in result.stdout:
            raise RuntimeError("shared-cluster leakage or Kubernetes transport failure: " + result.stdout)
    print("PASS live shared-cluster leakage test")


if __name__ == "__main__":
    if "--live-kind" in sys.argv:
        live_kind_isolation()
    else:
        unittest.main(verbosity=2)
