# Disable Auto-Mounted Tokens

## Task

1. Create a pod named `no-token-pod` in `sa-lab` with image `busybox:1.36` command `sleep 3600` that:
   - Uses the `app-sa` ServiceAccount
   - Sets `automountServiceAccountToken: false`
2. Verify the token is NOT mounted:
   ```
   kubectl exec no-token-pod -n sa-lab -- ls /var/run/secrets/kubernetes.io/serviceaccount/ 2>&1
   ```
   This should fail or show nothing.
3. Save "false" to `/root/automount-value.txt`.

## Hint

Set `automountServiceAccountToken: false` at the pod spec level to prevent automatic token mounting.
