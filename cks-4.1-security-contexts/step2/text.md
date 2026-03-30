# Enable readOnlyRootFilesystem

Prevent containers from writing to the root filesystem to limit the impact of compromises.

## Task

1. Create a pod named `readonly-pod` in `secctx-lab` with:
   - `readOnlyRootFilesystem: true`
   - Image: `nginx`
   - emptyDir volumes for `/var/cache/nginx`, `/var/run`, and `/tmp`
2. Verify nginx starts and can serve traffic. Save the pod IP and a curl test to `/root/readonly-test.txt`.
3. Verify that writing to `/etc/` fails inside the container. Save the error to `/root/readonly-write-test.txt`.

## Hint

nginx needs writable `/var/cache/nginx` for proxy cache and `/var/run` for PID file. Mount emptyDir volumes at these paths.
