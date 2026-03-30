# Audit System Calls

The Linux Audit Framework (`auditd`) records system-level events: file access, system calls, user logins, and security policy changes. It is essential for compliance (PCI-DSS, HIPAA) and incident forensics.

## Core Components

| Component | Role |
|-----------|------|
| `auditd` | Daemon that writes audit logs to `/var/log/audit/audit.log` |
| `auditctl` | Runtime rule management |
| `ausearch` | Search audit logs |
| `aureport` | Generate audit reports |

## Rule Types

```bash
# Watch a file for specific access types
auditctl -w /etc/passwd -p wa -k passwd_changes
#   -w = watch path
#   -p = permission filter (r=read, w=write, x=execute, a=attribute change)
#   -k = key for searching logs

# List current rules
auditctl -l

# Delete all rules
auditctl -D
```

## Task

1. Install `auditd` if not already installed: `apt-get install -y auditd`
2. Start the audit daemon: `service auditd start`
3. Add an audit rule that watches `/etc/passwd` for write and attribute changes (`-p wa`)
4. Tag the rule with key `passwd_monitor`
5. List current audit rules and save the output to `/root/audit-rules.txt`

<details>
<summary>Refer to: auditctl(8), auditd(8)</summary>
See <code>man auditctl</code> for the <code>-w</code> (watch) and <code>-p</code> (permission) options. Use <code>auditctl -l</code> to list all active rules.
</details>
