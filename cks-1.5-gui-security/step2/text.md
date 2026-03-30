# Create Restricted RBAC for Dashboard Access

Instead of cluster-admin, create a read-only role appropriate for a monitoring dashboard.

## Task

1. Create a ClusterRole named `dashboard-viewer` that allows:
   - `get`, `list`, `watch` on: pods, deployments, services, namespaces, nodes
   - No access to secrets, configmaps, or other sensitive resources
2. Create a ClusterRoleBinding named `dashboard-readonly-binding` that binds `dashboard-viewer` to the `dashboard-readonly` ServiceAccount.
3. Verify the readonly account cannot access secrets: `kubectl auth can-i get secrets -n default --as=system:serviceaccount:kubernetes-dashboard:dashboard-readonly` and save the result to `/root/readonly-secrets-check.txt`.

## Hint

Use `kubectl create clusterrole dashboard-viewer --verb=get,list,watch --resource=pods,deployments,services,namespaces,nodes`.
