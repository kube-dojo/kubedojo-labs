# Create Least-Privilege Roles and ClusterRoles

Design roles that grant the minimum permissions required for each use case.

## Task

1. Create a Role named `deployer` in `rbac-lab` namespace that allows:
   - `get`, `list`, `watch`, `create`, `update`, `patch` on `deployments`
   - `get`, `list` on `pods` and `services`
   - No access to secrets or configmaps
2. Create a Role named `log-viewer` in `rbac-lab` namespace that allows:
   - `get`, `list` on `pods`
   - `get` on `pods/log`
3. Create a ClusterRole named `node-viewer` that allows:
   - `get`, `list`, `watch` on `nodes`
4. Save all three role YAML definitions to `/root/roles.yaml`.

## Hint

For `pods/log`, use the subresource syntax in the Role: `resources: ["pods/log"]`. Use `kubectl create role` for speed.
