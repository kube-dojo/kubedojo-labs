# Enable Audit Logging on the API Server

Configure the API server to use the audit policy and write logs to a file.

## Task

1. Add these flags to the API server manifest (`/etc/kubernetes/manifests/kube-apiserver.yaml`):
   - `--audit-policy-file=/etc/kubernetes/audit/policy.yaml`
   - `--audit-log-path=/var/log/kubernetes/audit/audit.log`
   - `--audit-log-maxage=7`
   - `--audit-log-maxbackup=3`
   - `--audit-log-maxsize=50`
2. Add volume mounts for the audit policy and log directory.
3. Wait for the API server to restart and verify it is healthy.
4. Trigger some audit events by creating and deleting resources, then verify the audit log exists and contains entries. Save the first 20 lines to `/root/audit-sample.txt`.

**WARNING**: Edit carefully — mistakes will break the API server. Use the backup from setup.

## Hint

Add hostPath volumes for `/etc/kubernetes/audit` (read-only) and `/var/log/kubernetes/audit` (read-write). Mount them into the API server container.
