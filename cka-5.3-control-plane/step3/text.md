## Fix etcd Issues

etcd stores all cluster state. Understanding how to check its health and create snapshots is critical.

### Task

1. Check etcd health using `etcdctl`
2. Create an etcd snapshot saved to `/root/etcd-backup.db`
3. Verify the snapshot

```bash
# Find etcd certificates
grep -E "etcd|cert|key" /etc/kubernetes/manifests/etcd.yaml | grep -v "#"

# Check etcd health
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
  endpoint health

# Create snapshot
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
  snapshot save /root/etcd-backup.db

# Verify snapshot
ETCDCTL_API=3 etcdctl snapshot status /root/etcd-backup.db --write-table
```

<details>
<summary>Hint: etcd certificate paths</summary>

Certificates are typically at:
- CA: `/etc/kubernetes/pki/etcd/ca.crt`
- Client cert: `/etc/kubernetes/pki/etcd/healthcheck-client.crt`
- Client key: `/etc/kubernetes/pki/etcd/healthcheck-client.key`
- Or check the etcd pod manifest: `cat /etc/kubernetes/manifests/etcd.yaml`
</details>
