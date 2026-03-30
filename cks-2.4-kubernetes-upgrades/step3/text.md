# Verify Cluster Health Post-Upgrade

After any upgrade, verify the cluster is fully functional.

## Task

1. Verify all nodes are Ready and save to `/root/node-status.txt`.
2. Check all system pods in `kube-system` are Running and save to `/root/system-pods.txt`.
3. Verify the test application in `upgrade-test` namespace is still running. Save the pod status to `/root/app-status.txt`.
4. Check component statuses and save to `/root/component-status.txt`.

## Hint

Use `kubectl get nodes`, `kubectl get pods -n kube-system`, and `kubectl get componentstatuses` (deprecated but still useful).
