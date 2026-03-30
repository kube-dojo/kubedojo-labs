#!/bin/bash
crictl images | grep -E "nginx|IMAGE" > /root/image-sizes.txt

cat > /root/minimal-Dockerfile << 'DOCKERFILE'
# Stage 1: Build
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/server .

# Stage 2: Minimal runtime
FROM gcr.io/distroless/static:nonroot
COPY --from=builder /app/server /server
USER 65534:65534
ENTRYPOINT ["/server"]
DOCKERFILE

cat > /root/image-hardening.txt << 'BEST'
1. Use specific version tags, never :latest — pin to exact versions
2. Use minimal base images (distroless, alpine, scratch) to reduce attack surface
3. Multi-stage builds — keep build tools out of the runtime image
4. Run as non-root user (USER instruction in Dockerfile)
5. Scan images for CVEs before deployment (trivy, grype, snyk)
6. Sign images and verify signatures before deployment (cosign, notary)
7. Remove shells and package managers from production images
8. Use .dockerignore to prevent leaking secrets into build context
BEST
