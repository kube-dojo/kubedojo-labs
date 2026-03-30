## Diagnose Control Plane Health

The first step in control plane troubleshooting is checking the health of all components.

### Task

1. Check control plane pod status in `kube-system`
2. Verify component health using the API
3. Save the health report to `/root/cp-health.txt`

```bash
# Check control plane pods
kubectl get pods -n kube-system -l tier=control-plane

# Check component status (deprecated but still useful)
kubectl get componentstatuses 2>/dev/null || echo "componentstatuses deprecated"

# Check API server health endpoint
curl -k https://localhost:6443/healthz 2>/dev/null

# Check all control plane endpoints
for endpoint in healthz livez readyz; do
  echo "$endpoint: $(curl -sk https://localhost:6443/$endpoint)"
done

# Save health report
kubectl get pods -n kube-system -l tier=control-plane -o wide > /root/cp-health.txt
echo "---" >> /root/cp-health.txt
curl -sk https://localhost:6443/healthz >> /root/cp-health.txt
```

<details>
<summary>Hint: Control plane health checks</summary>

Key commands:
- `kubectl get pods -n kube-system` — check pod status
- `crictl ps` — check container runtime directly
- `curl -k https://localhost:6443/healthz` — API server health
- `journalctl -u kubelet` — kubelet logs
- `ls /etc/kubernetes/manifests/` — static pod manifests
</details>
