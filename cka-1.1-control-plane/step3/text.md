# API Server Flags

The API server has many configuration flags that control cluster behavior. Knowing where to find them is important for troubleshooting.

**Key flags:**
- `--service-cluster-ip-range` — CIDR range for ClusterIP services
- `--etcd-servers` — etcd endpoint(s)
- `--authorization-mode` — how requests are authorized (RBAC, Node, etc.)
- `--enable-admission-plugins` — active admission controllers

## Task

Find the `--service-cluster-ip-range` value from the API server configuration and save it to `/root/service-cidr.txt`.

<details>
<summary>Hint</summary>

Check the API server manifest: 
```bash
grep service-cluster-ip-range /etc/kubernetes/manifests/kube-apiserver.yaml > /root/service-cidr.txt
```
The value is typically something like `10.96.0.0/12`.
</details>