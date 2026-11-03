# Kubernetes reference evidence

The five Kubernetes references have 18 classified steps, 18 learner transcripts,
18 requirement maps, and 27 negative fixtures. Seventeen steps are `change`.
`prereq-k8s-1.3-pods/step4` is `delete`. None declares `initial_pass`.

The maps enumerate the outcomes in each step's "Your task" instructions. The
transcripts also run the main instructional examples in order. Hints,
alternative commands, and optional exercises are excluded. The pod watch uses
`timeout --signal=INT 2s` to replay the instructed Ctrl+C, with expected status
124. Explicit waits and request time limits bound asynchronous cluster work.

## Lab repairs

The table lists every edited existing lab script. Paths are relative to the
repository root. Each text reference is relative to the script's step directory.

Controlled probes ran the baseline from `git show 18632b3:<path>` and the edited
script with the same inputs. The probes substituted `kubectl`, `curl`, and
`sleep`; both checker versions used an identical temporary-home remapping to
avoid writing learner files into a host user's home. They exercised the shell
logic, not a live Kubernetes cluster. `U` is the unmet requirement and `M` is
the met requirement. Every listed checker returned 0 for its controlled met
state after the repair.

| Script | Defect and required outcome | Text reference | Controlled before and after |
|---|---|---|---|
| `prereq-k8s-1.1-first-cluster/step1/verify.sh` | Stripping all whitespace accepted a saved value containing a leading space. The file must contain only the node name. | `text.md:39`, `text.md:45` | Saved ` kind-control-plane` against node `kind-control-plane`: U before 0, after 1; M after 0. |
| `prereq-k8s-1.1-first-cluster/step2/verify.sh` | Any positive integer passed. Compare the saved number with the actual kube-system pod count. | `text.md:32`, `text.md:38` | Saved 8 against 7 live pods: U before 0, after 1; M after 0. |
| `prereq-k8s-1.2-kubectl/step1/verify.sh` | A file containing only `coredns` passed. Require the default table header and every live pod name. | `text.md:41`, `text.md:47` | Saved `coredns` against three live pod names: U before 0, after 1; complete table M after 0. |
| `prereq-k8s-1.2-kubectl/step4/verify.sh` | Comment text resembling required fields passed without a valid manifest. Parse the manifest and check Pod kind, exact name, and exact image. | `text.md:47` | Malformed YAML with matching comments: U before 0, after 1; valid Pod M after 0. |
| `prereq-k8s-1.3-pods/step1/verify.sh` | A Running pod with the wrong image passed. The task requires a pod named web using nginx:1.25. Read the image directly; the task does not add a phase requirement. | `text.md:37` | Running web with nginx:1.26: U before 0, after 1; nginx:1.25 M after 0. |
| `prereq-k8s-1.3-pods/step2/verify.sh` | A substring match accepted a different image, and queries depended on the current namespace. Check default explicitly and compare the exact image. | `text.md:6`, `text.md:7`, `text.md:8` | Image `evil/nginx:1.25-evil`, correct label: U before 0, after 1; exact image M after 0. The namespace fixture puts the otherwise correct pod in another namespace. |
| `prereq-k8s-1.3-pods/step3/verify.sh` | Any IPv4-shaped string passed. Compare the saved value with web's actual pod IP. | `text.md:42` | Saved 192.0.2.1 against live 10.244.0.5: U before 0, after 1; actual IP M after 0. |
| `prereq-k8s-1.3-pods/step4/solution.sh` | Deleted api instead of the secure-pod from step 2. Delete the required pod and bound completion. | `text.md:6` | Stateful substitute with api and secure-pod present: before solution 0 then verify 1; after solution 0 then verify 0. |
| `prereq-k8s-1.3-pods/step4/verify.sh` | Any API error was interpreted as successful deletion. Require a successful list before checking absence. Report dependency errors as exit 2, separately from an unmet outcome's exit 1. | `text.md:6` | API request failure: before 0, after 2; successful empty pod list M after 0. |
| `prereq-k8s-1.4-deployments/step1/verify.sh` | Three replicas with any image passed. Check nginx:1.25 as well as three replicas. | `text.md:6` | Three replicas with nginx:1.26: U before 0, after 1; correct image M after 0. |
| `prereq-k8s-1.4-deployments/step2/verify.sh` | Checked only a potentially stale ready count, accepting a desired scale of four with five ready pods. Check the scale requested by the task. | `text.md:37` | spec.replicas 4 and status.readyReplicas 5: U before 0, after 1; desired five M after 0. |
| `prereq-k8s-1.5-services/step2/solution.sh` | Exhausting every curl attempt returned success from the loop's final sleep. Return failure after exhaustion and bound each request. | `text.md:32` | Every curl returns 7: U before 0, after 1; successful response M after 0. |
| `prereq-k8s-1.5-services/step2/verify.sh` | A file containing `nginx welcome` passed without the service response. Compare the saved body with the live ClusterIP response. | `text.md:32` | Saved `nginx welcome` against full HTML: U before 0, after 1; actual saved HTML M after 0. |

## Validation and limits

The deterministic validation parsed every reference manifest and every JSON-subset
YAML map, checked each fixture path, and ran `bash -n` on every shell file in the
18 step directories. It returned:

```text
PASS: 18 classified K8s steps; all learners, maps, fixtures and bash syntax valid
PASS: five scenarios, 18 classes, 18 transcripts, 18 maps, 27 fixtures, 73 parsed shell chunks; index changes are class-only
PASS: real harness Shell accepts bounded watch status124 and preserves the next command
```

The controlled repair probes returned the exit values in the table. Docker,
kind, and kubectl are absent on the author host. Fresh-cluster execution,
learner/solution/fixture runs, image pulls, service networking, and the
20-minute pull request bound require CI evidence.

## Text finding for the lane

`prereq-k8s-1.2-kubectl/step4/text.md:16` puts `--dry-run=client -o yaml`
after `-- sleep 3600`. Kubectl treats those tokens as the container command's
arguments and creates a real pod instead of emitting the described manifest.
This is an optional illustration introduced with "You can redirect it", so
the canonical transcript uses the earlier working dry-run example and the
required nginx task. The text remains unchanged under the D1 edit grant.
The kube-dojo lane owns this finding.
