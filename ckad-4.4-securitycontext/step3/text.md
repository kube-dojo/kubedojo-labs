# Run a Non-Root Container

## Task

1. Create a pod named `nonroot-pod` in `security-lab` with image `nginx:1.25` that:
   - Sets `runAsNonRoot: true` at the pod level
   - Sets `runAsUser: 1000` at the pod level
   - Sets `allowPrivilegeEscalation: false` at the container level

   Note: nginx normally needs root, but we set the user anyway to demonstrate the securityContext (the pod may not start nginx correctly, but the security settings are what matter).

2. Save the `runAsNonRoot` value to `/root/nonroot-value.txt`.
3. Save the `allowPrivilegeEscalation` value to `/root/priv-escalation.txt`.

## Hint

`runAsNonRoot: true` at pod level prevents any container from running as root. `allowPrivilegeEscalation: false` at container level prevents gaining additional privileges.
