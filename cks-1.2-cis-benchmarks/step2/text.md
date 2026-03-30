# Fix API Server Benchmark Failures

Address common CIS benchmark failures in the API server configuration.

## Task

1. Examine the kube-apiserver manifest at `/etc/kubernetes/manifests/kube-apiserver.yaml`.
2. Ensure the following flags are set (add or modify as needed):
   - `--profiling=false`
   - `--audit-log-path=/var/log/kubernetes/audit.log`
   - `--audit-log-maxage=30`
   - `--audit-log-maxbackup=10`
   - `--audit-log-maxsize=100`
3. Create the required directories for audit logs.
4. Wait for the API server to restart and verify it is healthy. Save the API server status to `/root/apiserver-status.txt`.

**WARNING**: Editing static pod manifests restarts the component. Save a backup first.

## Hint

Copy the manifest before editing: `cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-backup.yaml`. After editing, the kubelet will restart the pod.
