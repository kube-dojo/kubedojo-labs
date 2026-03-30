# Audit and Compare Syscall Usage

Understand how to audit which syscalls your containers actually need.

## Task

1. Create `/root/seccomp-audit.json` — a seccomp profile that logs all syscalls instead of blocking:
   - `defaultAction`: `SCMP_ACT_LOG`
2. Save the profile to `/var/lib/kubelet/seccomp/profiles/audit.json`.
3. Create a pod named `audit-pod` in `seccomp-lab` using this audit profile.
4. Create `/root/seccomp-best-practices.txt` with at least 4 seccomp best practices for CKS.

## Hint

`SCMP_ACT_LOG` logs syscalls without blocking. Check `dmesg` or audit logs to see which syscalls are used. Use this to build a minimal allow-list.
