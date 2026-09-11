# Audit RBAC Permissions and Detect Over-Privilege

Identify over-permissioned accounts and risky RBAC configurations.

## Task

1. List all ClusterRoleBindings that reference `cluster-admin` and save to `"$HOME"/cluster-admin-bindings.txt`.
2. Find all ServiceAccounts that have `cluster-admin` access and save to `"$HOME"/overprivileged-sa.txt`.
3. Check if the `secret-admin` ServiceAccount in `rbac-lab` has any bindings. Create `"$HOME"/secret-admin-audit.txt` with the results.
4. Create a file `"$HOME"/rbac-risks.txt` listing at least 3 RBAC security risks to watch for.

## Hint

Use `kubectl get clusterrolebindings -o json` and filter with jsonpath or jq for subjects referencing cluster-admin.
