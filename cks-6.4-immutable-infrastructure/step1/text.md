# Create Immutable Containers

Configure containers with read-only root filesystems and minimal writable directories.

## Task

1. Create a pod named `immutable-nginx` in `immutable-lab` with:
   - `readOnlyRootFilesystem: true`
   - `runAsNonRoot: true`, `runAsUser: 101`
   - `allowPrivilegeEscalation: false`
   - Drop ALL capabilities, add NET_BIND_SERVICE
   - emptyDir volumes for `/var/cache/nginx`, `/var/run`, `/tmp`
2. Verify nginx starts and serves traffic. Save test result to `/root/immutable-test.txt`.
3. Verify that writing to the root filesystem fails. Save error to `/root/write-denied.txt`.
4. Verify that writing to the emptyDir volume `/tmp` succeeds. Save result to `/root/tmp-write.txt`.

## Hint

The key to immutable containers: readOnlyRootFilesystem prevents all writes except to mounted volumes. emptyDir volumes provide the minimal writable space needed.
