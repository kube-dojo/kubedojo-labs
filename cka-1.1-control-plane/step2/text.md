# Examine etcd Directly

etcd is the control plane's source of truth. For CKA troubleshooting, you need to be comfortable talking to it directly instead of only looking at pod specs.

## Task

Use `etcdctl` on the control plane node to inspect the live etcd member and confirm the endpoint is healthy.

You must use the local TLS material from `/etc/kubernetes/pki/etcd/` and query the member on `https://127.0.0.1:2379`.

Run both:

1. `member list`
2. `endpoint health`

Suggested command shape:

```bash
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
  member list
```

<details>
<summary>Hint</summary>

Use the same flags for `endpoint health`. If you are unsure which certs to use, inspect `/etc/kubernetes/manifests/etcd.yaml`.
</details>
