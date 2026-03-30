# Review and Harden API Server Authentication

Examine current authentication configuration and disable insecure options.

## Task

1. Examine the API server manifest at `/etc/kubernetes/manifests/kube-apiserver.yaml`.
2. Save all authentication-related flags (containing "auth", "token", "cert") to `/root/auth-flags.txt`.
3. Verify that anonymous authentication is handled properly. Check if `--anonymous-auth` is set and save the finding to `/root/anonymous-auth.txt`.
4. Verify that `--insecure-port` is not set (or set to 0). Save the finding to `/root/insecure-port.txt`.

## Hint

Use `grep -E '(auth|token|cert|insecure)' /etc/kubernetes/manifests/kube-apiserver.yaml` to find relevant flags.
