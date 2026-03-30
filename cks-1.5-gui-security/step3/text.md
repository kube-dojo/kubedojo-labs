# Audit Dashboard Security Configuration

Review the RBAC setup and create a security audit document.

## Task

1. List all ClusterRoleBindings that reference the `kubernetes-dashboard` namespace and save to `/root/dashboard-bindings.txt`.
2. Compare what `dashboard-admin` can do vs `dashboard-readonly`. Save a comparison to `/root/rbac-comparison.txt` with format:
   ```
   dashboard-admin: <can-i result for secrets>
   dashboard-readonly: <can-i result for secrets>
   ```
3. Delete the dangerous `dashboard-admin-binding` ClusterRoleBinding.
4. Verify deletion and save remaining dashboard bindings to `/root/final-bindings.txt`.

## Hint

Use `kubectl get clusterrolebindings -o wide | grep kubernetes-dashboard` to find relevant bindings.
