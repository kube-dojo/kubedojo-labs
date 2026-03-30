## Fix API Server Issues

The API server is a static pod managed by kubelet. Its manifest is at `/etc/kubernetes/manifests/kube-apiserver.yaml`. Configuration errors in this file will cause the API server to fail.

### Task

1. Examine the API server manifest and understand its key parameters
2. Identify the `--service-cluster-ip-range` and `--etcd-servers` flags
3. Back up the current manifest and save key configuration to `/root/apiserver-config.txt`

```bash
# View the API server manifest
cat /etc/kubernetes/manifests/kube-apiserver.yaml

# Extract key flags
grep -E "service-cluster-ip-range|etcd-servers|secure-port|advertise-address" /etc/kubernetes/manifests/kube-apiserver.yaml

# Save configuration
grep -E "^\s+--" /etc/kubernetes/manifests/kube-apiserver.yaml > /root/apiserver-config.txt

# Backup
cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-backup.yaml
```

<details>
<summary>Hint: API server troubleshooting</summary>

Common API server issues:
- Wrong `--etcd-servers` endpoint
- Invalid certificate paths (`--tls-cert-file`, `--tls-private-key-file`)
- Wrong `--service-cluster-ip-range`
- If API server is down: `crictl ps -a | grep apiserver` and `crictl logs <id>`
- After editing manifest, kubelet auto-restarts the pod
</details>
