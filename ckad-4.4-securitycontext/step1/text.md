# Set User and Group Security Contexts

## Task

1. Create a pod named `user-pod` in `security-lab` with image `busybox:1.36` and command `sh -c "id; sleep 3600"` that:
   - Runs as user ID 1000 (`runAsUser: 1000`)
   - Runs as group ID 3000 (`runAsGroup: 3000`)
   - Has fsGroup 2000 (`fsGroup: 2000`)
2. Verify the user by checking the pod logs:
   ```
   kubectl logs user-pod -n security-lab
   ```
3. Save the output of `id` command to `/root/user-id.txt`.

## Hint

`runAsUser` and `runAsGroup` go under `spec.securityContext` (pod level). Use `kubectl logs` to see the output of the `id` command.
