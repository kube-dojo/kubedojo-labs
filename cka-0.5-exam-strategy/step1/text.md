# Bookmark Preparation

During the CKA exam, you can access `https://kubernetes.io/docs/` and its subdomains. Having bookmarks ready saves time searching.

**Essential pages to bookmark:**

| Topic | URL |
|-------|-----|
| Pod spec | `https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/` |
| Deployment spec | `https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/deployment-v1/` |
| Services | `https://kubernetes.io/docs/concepts/services-networking/service/` |
| RBAC | `https://kubernetes.io/docs/reference/access-authn-authz/rbac/` |
| NetworkPolicy | `https://kubernetes.io/docs/concepts/services-networking/network-policies/` |
| Persistent Volumes | `https://kubernetes.io/docs/concepts/storage/persistent-volumes/` |
| kubectl cheat sheet | `https://kubernetes.io/docs/reference/kubectl/cheatsheet/` |

## Task

Create `~/bookmarks.txt` with at least 4 URLs from `kubernetes.io` covering: pod spec, deployment spec, services, and RBAC.

One URL per line.

<details>
<summary>Hint</summary>

```bash
cat <<'EOF' > ~/bookmarks.txt
https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/
https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/deployment-v1/
https://kubernetes.io/docs/concepts/services-networking/service/
https://kubernetes.io/docs/reference/access-authn-authz/rbac/
EOF
```
</details>