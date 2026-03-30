# SELinux Concepts

SELinux operates in three modes:

| Mode | Behaviour |
|------|-----------|
| **Enforcing** | Policies are enforced; violations are blocked and logged |
| **Permissive** | Policies are not enforced; violations are logged only |
| **Disabled** | SELinux is completely turned off |

## Security Context Format

Every object in SELinux has a context with four fields:

```
user:role:type:level
```

Example: `system_u:object_r:httpd_sys_content_t:s0`

| Field | Purpose |
|-------|---------|
| `user` | SELinux user (e.g., `system_u`, `unconfined_u`) |
| `role` | Role for RBAC (e.g., `object_r`, `system_r`) |
| `type` | Type enforcement label (most important for policy decisions) |
| `level` | MLS/MCS sensitivity level (e.g., `s0`) |

## Key Commands

```bash
getenforce              # Show current mode
sestatus                # Detailed SELinux status
ls -Z /etc/passwd       # Show file context
ps -eZ                  # Show process contexts
id -Z                   # Show current user context
```

## Task

1. Check whether SELinux is installed by running `sestatus` and `getenforce`
2. List the three available SELinux modes
3. Save a status report to `/root/selinux-status.txt` containing:
   - Output of `sestatus` (or error message if SELinux is not enforcing)
   - Output of `getenforce`
   - A brief note listing the three modes: enforcing, permissive, disabled

<details>
<summary>Refer to: sestatus(8), getenforce(8)</summary>
See <code>man sestatus</code> for status output format. On systems without SELinux kernel support, these commands may report "disabled" — document that finding.
</details>
