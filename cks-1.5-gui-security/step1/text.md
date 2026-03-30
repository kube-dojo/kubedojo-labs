# Deploy the Kubernetes Dashboard Securely

Deploy the Kubernetes Dashboard with security-focused configuration.

## Task

1. Create a ServiceAccount named `dashboard-admin` in the `kubernetes-dashboard` namespace.
2. Create a ServiceAccount named `dashboard-readonly` in the `kubernetes-dashboard` namespace.
3. Create a ClusterRoleBinding named `dashboard-admin-binding` binding `dashboard-admin` to the `cluster-admin` ClusterRole.
4. Document in `/root/dashboard-risk.txt` why giving `cluster-admin` to a dashboard ServiceAccount is dangerous (at least 3 risks, one per line).

## Hint

Use `kubectl create serviceaccount` and `kubectl create clusterrolebinding`. Think about what `cluster-admin` can do — delete namespaces, read secrets, modify RBAC.
