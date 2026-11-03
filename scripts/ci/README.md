# Scenario test evidence

D1 tests the test infrastructure. A successful reference run supplies executable
evidence, not Killercoda certification. D2 also needs a native walkthrough at
the same commit. Kernel, runtime, networking, startup and terminal differences
remain D2 work.

## Run the checks

From the repository root:

```bash
python3 scripts/ci/scenarios.py
python3 scripts/ci/self-test.py
bash scripts/test-scenario.sh prereq-0.8-packages
bash scripts/test-k8s-scenario.sh prereq-k8s-1.3-pods
```

The first two commands need Python 3. The execution commands need Docker on a
disposable VM. Kubernetes execution also needs kind v0.33.0. The workflow pins
its executable checksum. Do not run privileged lab code on a machine holding
credentials or private-network routes. The security boundary is the entire
ephemeral GitHub-hosted VM. Privileged code can defeat an in-job firewall.

`--all` runs every scenario matching the wrapper's backend. Both wrappers return
the host driver's exit status. `--event pull_request --touched true` makes an
observed residual failure fatal. `--event push` and `--event schedule` preserve
the failure report for the lane to file an issue without failing residual runs.
A harness-only PR executes all residuals with `--touched false`; an individual
residual becomes fatal when that PR also changes its directory.
Local wrapper runs always return nonzero on an observed execution failure.

## Coverage and reports

`reports/inventory.json` lists every scenario, its structural result, execution
selection, and residual certification gaps. Structural validation checks every
declared text, background, foreground, verify and solution path. It rejects
missing paths, absolute paths and paths escaping the scenario. The templates
are not counted as scenarios. Reference evidence validation also requires a
class, transcript, solution and checker-adequacy inputs as applicable.

`reports/<scenario>.json` records each step's transcript, solution, fixture and
adequacy results. Full per-run records include setup and command exits, expected
output checks, verification and errors. Unrun steps remain `not run`. Residual
steps remain `not replayable` and `checker adequacy not proven`, even if their
solution execution passes. Missing input, crash, timeout and a verifier's
negative exit are distinct results; only exit 1 is a negative verification.

The fixed coverage denominator is 144 scenarios and 491 steps. The ten reference
scenarios have 35 steps. The remaining 134 scenarios are uncertified. The
inventory enumerates all of them without classifying their steps or inventing
transcripts. Its JSON can be regenerated with the first command above.

Reports are untrusted data. Scenario code can compromise its VM and forge them.
They are never executed, imported as configuration, or used to authorize a
merge. The CI Gate checks job conclusions rather than report contents. The lane
owns issue creation outside the execution jobs and D2 certification.

## Transcript format

`learner.sh` lives next to the step's declared text. It records one canonical
path from the main instructions and required task, excluding hints, alternatives
and optional exercises. Editor tasks record the requested final edit with
noninteractive shell commands. Each annotation precedes a shell chunk:

```bash
# expect-exit: 0
printf 'hello\n' > "$HOME/result.txt"
# expect-exit: 0
# expect-output: ^hello$
cat "$HOME/result.txt"
# expect-exit: 1
which deliberately-absent-command
```

The default expected status is 0. Each new `expect-exit` starts a chunk, which
may contain a heredoc. Use a separate annotation for each command. Successful
chunks run with `errexit`, so an earlier failed command cannot hide behind a
successful last command. Expected nonzero chunks check the documented command's
final status. `expect-output` is a Python regular expression with multiline
matching, checked against that chunk's combined standard output and error.
Every `observe` chunk requires an output assertion. A bounded SIGINT replays an
explicit Ctrl+C instruction; its timeout status is declared rather than hidden.

All learner chunks and steps share one shell, preserving current directory,
variables and environment. The learner is ubuntu on Ubuntu and root inside the
kind node. Verification runs as root with the learner's HOME. A whole solution
run starts independently and executes only the author's solution scripts in
manifest order. The solution path is the manifest's `solution`, or `solution.sh`
next to the declared text for older manifests. No hints or sorted step-directory
fallback is permitted.

## Requirement-map and fixture format

`requirements.yaml` is JSON, a strict subset of YAML. Its structure is:

```json
{
  "requirements": [
    {
      "id": "saved-output",
      "outcome": "Save the complete command output, text.md:12",
      "assertion": "The corresponding assertion in verify.sh",
      "negative": "negative/output-missing.sh"
    }
  ]
}
```

The reviewer derives the outcomes from the text and checks every assertion and
fixture. Assertion strings explain the actual checker code; they are never
executed as a second checker. Every required task outcome has a unique id and
fixture. A fixture establishes the current step's other outcomes and leaves
only its named outcome unmet. It must return 0; a fixture crash is not proof.
The verifier must then return 1. Always-zero verifiers therefore fail.

Each negative run starts from a fresh environment, runs setup and replays every
earlier step's learner transcript before applying that one fixture. It never
reuses another fixture's state. Learner and solution runs likewise start fresh
and keep their environment across their own steps. A fresh kind cluster is
created for every run and deleted on success, failure or interruption.

For `change`, and `observe` with a checker, verification must fail before the
step and pass afterward. An optional top-level `initial_pass` string explains
a prerequisite, cumulative or idempotent exception for review. None of the ten
references needs an exception. For `delete`, verification must fail before and
pass after deletion; fixtures retain each required target. For `expect-error`,
the transcript must contain the documented nonzero exit and verification must
pass afterward. Packages step 3 declares exit 1 for `which wget`. `info` has no
transcript or verifier and executes nothing.

## CI execution and bounds

Pull requests select changed scenario directories. Harness, workflow and shared
template changes select all scenarios. Main pushes and nightly select all 144.
Every scenario is a separate job, with at most sixteen concurrent jobs. A scenario
has a 17-minute wall-clock budget including image build, each lane has a
10-minute transport bound, commands have 120 seconds, and cluster startup has
180 seconds. The execution job has 18 minutes; inventory has one and the gate
has one. The one-lab pull-request budget is 20 minutes of job execution;
provider queue delays are measured separately. The live run establishes actual
completion time; configuration bounds alone do not prove successful execution.

Ubuntu uses 24.04 with systemd. Kubernetes uses the digest-pinned 1.37.0 node
published with kind v0.33.0, extended only with driver dependencies. Images are
built once per job and never stored in an Actions cache. All jobs revoke cache
access, use read-only contents permissions and pinned actions, and retain only
the designated report JSON files. Fork pull requests have an explicit guard.
No job attaches private networking or receives project secrets or credentials.

## Self-tests

`self-test.py` names each defect it detects: always-zero verification, failing
solution, missing required verification, hint preference, sorted step order,
shared-cluster reuse, missing failure propagation, wrong expected status and
unmatched expected output. Additional cases reject verifier crashes, missing
solutions, hidden earlier command failures and timeouts, and check PR selection.

The ordinary tests run real shell commands in temporary fixture trees. Their
cluster lifecycle test substitutes CLI transport to inspect creation and
cleanup on failure. CI also runs `self-test.py --live-kind`: it creates a
cluster-scoped namespace in one fresh cluster and requires Kubernetes NotFound
in another. This catches namespace-only cleanup or accidental cluster reuse.

The per-script repair evidence is in [Ubuntu fixes](ubuntu-lab-fixes.md) and
[Kubernetes fixes](k8s-lab-fixes.md). Those controlled probes do not replace live
container and cluster execution.

The Ubuntu learner uses the ubuntu account. The previous harness also tested
root; matching Killercoda's terminal identity is an explicit D2 residual owned
by the kube-dojo lane. D1 does not certify that identity difference.
