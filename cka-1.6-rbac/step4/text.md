# ServiceAccounts

Pods use ServiceAccounts to authenticate with the API server. By default, pods use the `default` ServiceAccount, which has minimal permissions.

To grant a pod specific permissions:
1. Create a ServiceAccount
2. Create a Role with needed permissions
3. Bind the Role to the ServiceAccount with a RoleBinding

## Task

1. Create a ServiceAccount named `deploy-bot` in the `rbac-test` namespace.
2. Create a RoleBinding that binds the `pod-reader` role (from Step 1) to `deploy-bot`.
3. Verify that `deploy-bot` can get pods in the `rbac-test` namespace.

## Hint

```bash
kubectl create serviceaccount deploy-bot -n rbac-test
kubectl create rolebinding deploy-bot-binding --role=pod-reader --serviceaccount=rbac-test:deploy-bot -n rbac-test
kubectl auth can-i get pods --as=system:serviceaccount:rbac-test:deploy-bot -n rbac-test
```
