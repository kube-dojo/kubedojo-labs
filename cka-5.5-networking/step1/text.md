## Fix DNS Resolution Failure

The pod `dns-broken` in the `practice` namespace cannot resolve any DNS names because its `dnsPolicy` is set to `None` with a bogus nameserver.

### Task

1. Diagnose the DNS issue
2. Fix the pod by setting the correct `dnsPolicy`

```bash
# Test DNS from the broken pod
kubectl exec dns-broken -n practice -- nslookup kubernetes.default 2>&1 || echo "DNS failed"

# Check the pod's DNS configuration
kubectl exec dns-broken -n practice -- cat /etc/resolv.conf

# Compare with a working pod
kubectl exec pod-b -n practice -- cat /etc/resolv.conf
```

Fix by deleting and recreating with `dnsPolicy: ClusterFirst` (the default).

<details>
<summary>Hint: Fix DNS policy</summary>

```bash
kubectl delete pod dns-broken -n practice
kubectl run dns-broken --image=busybox:1.36 -n practice -- sleep 3600
```

Or explicitly set `dnsPolicy: ClusterFirst` in YAML.
</details>
