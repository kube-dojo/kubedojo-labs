# Roles and RoleBindings

A **Role** defines a set of permissions within a namespace. A **RoleBinding** grants those permissions to a user, group, or ServiceAccount.

**Key concepts:**
- Roles are namespace-scoped
- Verbs: `get`, `list`, `watch`, `create`, `update`, `patch`, `delete`
- Resources: `pods`, `deployments`, `services`, etc.

## Task

Create a Role named `pod-reader` in the `rbac-test` namespace that allows `get` and `list` operations on `pods`.

You can use either imperative commands or a YAML manifest.

<details>
<summary>Hint</summary>

Imperative: 
```bash
kubectl create role pod-reader --verb=get --verb=list --resource=pods -n rbac-test
```
</details>