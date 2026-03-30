# Fix Kubelet Benchmark Failures

The kubelet has its own CIS benchmark checks. Fix common configuration issues.

## Task

1. Examine the kubelet configuration at `/var/lib/kubelet/config.yaml`.
2. Ensure these security settings:
   - `authentication.anonymous.enabled: false`
   - `authorization.mode: Webhook`
   - `readOnlyPort: 0` (disable read-only port)
   - `protectKernelDefaults: true`
3. Restart the kubelet after changes: `systemctl restart kubelet`
4. Verify the kubelet is running and save its status to `/root/kubelet-status.txt`.

## Hint

Edit `/var/lib/kubelet/config.yaml` directly. Use `systemctl status kubelet` to check health after restart.
