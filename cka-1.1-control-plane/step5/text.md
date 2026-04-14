# Trace a kubectl Request

`kubectl` can show its own client-side request flow. On the CKA, `--v=8` is a fast way to see which URL path was requested, what headers were sent, and what status came back from the API server. To connect that request to the control plane backend, you can correlate the API path with the etcd key prefix that stores the same objects.

## Task

Capture an end-to-end trace artifact at `/var/tmp/cka-1.1-kubectl-trace.log`.

Requirements:

1. Use `kubectl --v=8`
2. Query pods in the `kube-system` namespace
3. Redirect the verbose trace from `stderr` into the log file
4. Append an etcd key listing for `/registry/pods/kube-system`
5. Confirm the artifact shows the API request path, a response status line, and the etcd key prefix

One clean way to do it:

```bash
kubectl --v=8 get pods -n kube-system 1>/dev/null 2>/var/tmp/cka-1.1-kubectl-trace.log
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
  get /registry/pods/kube-system --prefix --keys-only >> /var/tmp/cka-1.1-kubectl-trace.log
```

<details>
<summary>Hint</summary>

`-v=8` writes the trace to `stderr`, not `stdout`. The etcd key prefix for namespaced pods is `/registry/pods/<namespace>/...`.
</details>
