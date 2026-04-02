# Troubleshooting

When SELinux denies access, the denial is logged in the audit log. Understanding how to find and resolve these denials is the most practical SELinux skill.

## Troubleshooting Workflow

```
1. Identify the denial
   └── ausearch -m avc -ts recent
   └── grep "avc:  denied" /var/log/audit/audit.log

2. Understand the denial
   └── audit2why < /var/log/audit/audit.log
   └── sealert -a /var/log/audit/audit.log  (if setroubleshoot installed)

3. Fix the denial (choose one)
   ├── Fix file context:  restorecon -Rv /path
   ├── Toggle boolean:    setsebool -P boolean_name on
   └── Create custom policy: audit2allow -M mypolicy < /var/log/audit/audit.log

4. Verify the fix
   └── Test the operation again
   └── Check no new denials appear
```

## Key Troubleshooting Commands

| Command | Purpose |
|---------|---------|
| `ausearch -m avc` | Search for AVC (Access Vector Cache) denials |
| `audit2why` | Explain why a denial occurred |
| `audit2allow` | Generate a policy module to allow a denied action |
| `sealert` | Human-readable denial analysis (requires setroubleshoot) |
| `semodule -i` | Install a custom policy module |

## Task

1. Document the complete SELinux troubleshooting workflow
2. Include the purpose of each tool: `ausearch`, `audit2why`, `audit2allow`, `sealert`
3. Describe the three fix strategies: context fix, boolean toggle, custom policy
4. Save your documentation to `~/selinux-workflow.txt`
5. Include a note about how this applies to Kubernetes (container context denials)

<details>
<summary>Refer to: ausearch(8), audit2why(8), audit2allow(1)</summary>
See <code>man audit2allow</code> for generating custom policy modules. The tool reads audit log entries and produces Type Enforcement rules.
</details>
