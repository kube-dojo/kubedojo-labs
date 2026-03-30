# Map CKS Domains to Cluster Components

Understanding which Kubernetes components relate to each CKS domain helps you navigate the exam efficiently.

## Task

1. Inspect the kube-apiserver manifest and list all flags starting with `--` that relate to security (authentication, authorization, admission, audit, encryption). Save at least 5 such flags to `/root/security-flags.txt` (one per line, flag name only without values).
2. Check if RBAC is enabled by examining the API server's `--authorization-mode` flag. Save the authorization modes to `/root/auth-modes.txt`.
3. Check the kubelet configuration at `/var/lib/kubelet/config.yaml` for authentication and authorization settings. Save the `authentication.webhook.enabled` value to `/root/kubelet-auth.txt`.

## Hint

Use `grep` on the API server manifest and kubelet config. Focus on flags containing "auth", "admission", "audit", "encrypt", "tls".
