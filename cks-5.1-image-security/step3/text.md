# Analyze and Minimize Container Images

Smaller images have fewer vulnerabilities. Analyze image layers and size.

## Task

1. Compare image sizes for nginx variants and save to `/root/image-sizes.txt`:
   ```bash
   crictl images | grep nginx
   ```
2. Create a multi-stage Dockerfile concept at `/root/minimal-Dockerfile` that:
   - Uses a specific version tag (not latest)
   - Uses a minimal base image (alpine or distroless)
   - Runs as a non-root user
   - Has no shell or package manager
3. Create `/root/image-hardening.txt` with at least 5 image security best practices.

## Hint

Distroless images from `gcr.io/distroless/` have no shell, no package manager — smallest attack surface. Alpine-based images are a good middle ground.
