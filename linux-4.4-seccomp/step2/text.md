# Create a seccomp Profile

seccomp profiles are JSON files that define which syscalls are allowed or blocked. Docker and Kubernetes both consume this format.

## Profile Structure

```json
{
  "defaultAction": "SCMP_ACT_ALLOW",
  "syscalls": [
    {
      "names": ["chmod", "fchmod", "fchmodat"],
      "action": "SCMP_ACT_ERRNO"
    }
  ]
}
```

## Actions

| Action | Behaviour |
|--------|-----------|
| `SCMP_ACT_ALLOW` | Allow the syscall |
| `SCMP_ACT_ERRNO` | Block and return an error to the caller |
| `SCMP_ACT_KILL` | Kill the process immediately |
| `SCMP_ACT_KILL_PROCESS` | Kill the entire process (not just the thread) |
| `SCMP_ACT_LOG` | Allow but log the syscall |
| `SCMP_ACT_TRAP` | Send SIGSYS signal |

## Profile Design Strategies

**Allowlist (recommended for production)**:
- `defaultAction: SCMP_ACT_ERRNO` — block everything by default
- Explicitly allow only needed syscalls

**Denylist (easier to start with)**:
- `defaultAction: SCMP_ACT_ALLOW` — allow everything by default
- Block specific dangerous syscalls

## Task

Create a seccomp profile at `/root/seccomp-profile.json` that:

1. Uses `SCMP_ACT_ALLOW` as the default action (denylist approach)
2. Blocks the `chmod`, `fchmod`, and `fchmodat` syscalls with `SCMP_ACT_ERRNO`
3. Blocks the `reboot` syscall with `SCMP_ACT_ERRNO`
4. Verify the file is valid JSON with `jq . /root/seccomp-profile.json`

<details>
<summary>Refer to: Docker seccomp documentation, OCI runtime spec</summary>
The profile format follows the OCI runtime specification. See <a href="https://docs.docker.com/engine/security/seccomp/">Docker seccomp docs</a> for the full schema. Syscall names match <code>ausyscall --dump</code> output.
</details>
