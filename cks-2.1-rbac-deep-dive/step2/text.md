# Bind Roles to Users and Service Accounts

Create appropriate bindings for each service account.

## Task

1. Create a RoleBinding named `deployer-binding` in `rbac-lab` that binds the `deployer` role to `app-deployer` ServiceAccount.
2. Create a RoleBinding named `log-viewer-binding` in `rbac-lab` that binds the `log-viewer` role to `log-reader` ServiceAccount.
3. Create a ClusterRoleBinding named `node-viewer-binding` that binds the `node-viewer` ClusterRole to `app-deployer` ServiceAccount in `rbac-lab`.
4. Verify permissions with `kubectl auth can-i` for each ServiceAccount and save results to `/root/permission-check.txt`.

## Hint

Use `kubectl create rolebinding` and `kubectl create clusterrolebinding`. Test with `--as=system:serviceaccount:rbac-lab:app-deployer`.
