# Configure runAsNonRoot and runAsUser

Prevent containers from running as the root user.

## Task

1. Create a pod named `nonroot-pod` in `secctx-lab` with:
   - Pod-level: `runAsNonRoot: true`, `runAsUser: 1000`, `runAsGroup: 3000`, `fsGroup: 2000`
   - Image: `busybox`, command: `["sleep", "3600"]`
2. Verify the process runs as UID 1000 by checking `id` inside the container. Save to `/root/nonroot-id.txt`.
3. Create a pod named `root-fail` in `secctx-lab` with `runAsNonRoot: true` but using an image that runs as root (e.g., `nginx` without specifying a UID). Observe the failure and save the error to `/root/root-fail.txt`.
4. Fix the `root-fail` issue by adding `runAsUser: 101` (nginx user) and save the working pod as `/root/fixed-pod.yaml`.

## Hint

When `runAsNonRoot: true` is set, the container fails to start if the image runs as UID 0. Set `runAsUser` to override.
