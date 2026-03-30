# Configure Capabilities and Read-Only Filesystem

## Task

1. Create a pod named `cap-pod` in `security-lab` with image `busybox:1.36` and command `sleep 3600` that:
   - Drops ALL capabilities
   - Adds only `NET_BIND_SERVICE` capability
   - Has `readOnlyRootFilesystem: true`
   - Mounts an `emptyDir` at `/tmp` for writable temp space
2. Verify the capabilities:
   ```
   kubectl get pod cap-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.capabilities}'
   ```
3. Save the readOnlyRootFilesystem value to `/root/readonly-fs.txt`.

## Hint

Capabilities go under `spec.containers[].securityContext.capabilities` with `drop` and `add` arrays. `readOnlyRootFilesystem` is also at the container level.
