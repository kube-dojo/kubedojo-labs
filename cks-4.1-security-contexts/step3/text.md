# Control Privilege Escalation and Capabilities

Prevent privilege escalation and remove unnecessary capabilities.

## Task

1. Create a pod named `no-escalation` in `secctx-lab` with:
   - `allowPrivilegeEscalation: false`
   - `capabilities.drop: ["ALL"]`
   - `capabilities.add: ["NET_BIND_SERVICE"]`
   - Image: `nginx`, `runAsUser: 101`
2. Verify the pod cannot gain additional privileges. Save the capability set to `/root/pod-caps.txt`.
3. Create `/root/escalation-risks.txt` documenting:
   - What `allowPrivilegeEscalation` prevents (setuid/setgid binaries, ptrace)
   - Why dropping all capabilities is important
   - Which capabilities are most dangerous (SYS_ADMIN, NET_ADMIN, SYS_PTRACE)

## Hint

Use `kubectl exec <pod> -- cat /proc/1/status | grep Cap` to read the capability sets.
