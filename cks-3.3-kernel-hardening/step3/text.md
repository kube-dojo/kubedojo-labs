# Apply Comprehensive System Hardening

Combine multiple hardening techniques for a fully secured pod.

## Task

1. Create a pod named `hardened-complete` in `kernel-lab` with ALL of these security settings:
   - `runAsNonRoot: true`, `runAsUser: 1000`
   - `readOnlyRootFilesystem: true`
   - `allowPrivilegeEscalation: false`
   - Drop ALL capabilities
   - RuntimeDefault seccomp profile
   - Image: `nginx` (you may need a tmpfs for nginx to work)
2. Add a volume for `/var/cache/nginx` and `/var/run` as `emptyDir` so nginx can start.
3. Save the full pod YAML to `/root/hardened-pod.yaml`.
4. Create `/root/hardening-checklist.txt` listing all system hardening controls applied.

## Hint

Nginx needs write access to `/var/cache/nginx` and `/var/run` for PID files. Use emptyDir volumes to provide writable space while keeping the root filesystem read-only.
