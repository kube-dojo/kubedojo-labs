# seccomp Basics

seccomp restricts processes to a set of allowed system calls. The kernel checks every syscall against the process's seccomp filter before executing it.

## seccomp Modes

| Seccomp Field Value | Mode | Behaviour |
|---------------------|------|-----------|
| 0 | Disabled | No seccomp filtering |
| 1 | Strict | Only `read`, `write`, `exit`, `sigreturn` allowed |
| 2 | Filter (BPF) | Custom filter via BPF program (used by containers) |

## Checking seccomp Status

Every process exposes its seccomp mode in `/proc/PID/status`:

```bash
grep Seccomp /proc/1/status
# Seccomp:  0     (disabled)
# Seccomp:  2     (filter mode — common in containers)

grep Seccomp /proc/self/status
# Shows the current shell's seccomp status
```

## The /proc/PID/status File

This file contains many security-relevant fields:

```bash
cat /proc/1/status | grep -E "^(Name|Pid|Seccomp|NoNewPrivs|CapEff)"
```

## Task

1. Check the seccomp status of PID 1 (init/systemd)
2. Check the seccomp status of the current shell (`/proc/self/status`)
3. Save both results to `~/seccomp-status.txt`, including:
   - The Seccomp line from `/proc/1/status`
   - The Seccomp line from `/proc/self/status`
   - A brief explanation of what the values mean

<details>
<summary>Refer to: proc(5), seccomp(2)</summary>
See <code>man proc</code> for the <code>/proc/PID/status</code> fields. The <code>Seccomp</code> field values are: 0=disabled, 1=strict, 2=filter.
</details>
