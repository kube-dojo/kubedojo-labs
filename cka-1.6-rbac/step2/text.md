# ClusterRoles

A **ClusterRole** is like a Role but works cluster-wide. It can grant access to:
- Cluster-scoped resources (nodes, namespaces, PVs)
- Resources across all namespaces
- Non-resource URLs (e.g., `/healthz`)

## Task

Create a ClusterRole named `node-viewer` that allows `get` and `list` operations on `nodes`.

<details>
<summary>Hint</summary>

Imperative: 
```bash
kubectl create clusterrole node-viewer --verb=get --verb=list --resource=nodes
```
</details>