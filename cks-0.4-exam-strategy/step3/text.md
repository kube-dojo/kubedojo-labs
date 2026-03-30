# Complex Tasks — Audit Logging and Admission Control

Practice the most time-consuming CKS tasks.

## Task

1. Create an audit policy at `/etc/kubernetes/audit/exam-policy.yaml` that:
   - Logs all `create` and `delete` operations on `secrets` at `RequestResponse` level
   - Logs all operations in `kube-system` namespace at `Metadata` level
   - Logs everything else at `None` level
2. Create a file `/root/exam-notes.txt` with your exam strategy notes — list 3 quick-win tasks, 3 medium tasks, and 3 complex tasks (one per line, 9 lines total).

## Hint

Audit policy supports `verbs`, `namespaces`, and `resources` fields in rules. Refer to the Kubernetes audit documentation.
