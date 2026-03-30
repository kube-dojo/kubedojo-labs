# Use Image Digests Instead of Tags

Tags are mutable — the same tag can point to different images over time. Digests are immutable.

## Task

1. Pull the `nginx:latest` image digest using `crictl` or `docker`:
   ```bash
   crictl pull nginx:latest
   crictl images | grep nginx
   ```
   Save the image digest to `/root/nginx-digest.txt`.
2. Create a pod named `pinned-pod` in `image-lab` using the digest instead of the tag:
   ```
   image: nginx@sha256:<digest>
   ```
3. Verify the pod is using the digest by inspecting its spec. Save to `/root/pinned-image.txt`.
4. Create `/root/image-tag-risks.txt` documenting why tags are risky (at least 3 reasons).

## Hint

Use `crictl inspecti nginx:latest | grep -i digest` to find the digest. Format: `nginx@sha256:abc123...`
