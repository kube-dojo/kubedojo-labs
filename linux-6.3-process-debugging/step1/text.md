# strace Basics

`strace` intercepts and records system calls made by a process. It is invaluable for understanding what a process is doing at the kernel level.

## Tracing a Command

```bash
# Trace all syscalls of a command
strace ls /tmp 2>&1 | head -20

# Trace only file-related syscalls
strace -e trace=file ls /tmp 2>&1

# Trace a running process
strace -p <PID> -c    # Summary of syscalls
```

## Common Syscalls

| Syscall | Purpose |
|---------|---------|
| `open/openat` | Open a file |
| `read` | Read from file descriptor |
| `write` | Write to file descriptor |
| `stat` | Get file metadata |
| `mmap` | Map memory |
| `connect` | Network connection |

## Your Task

1. Run `strace` on `ls /tmp` and capture the output
2. Save it to `~/strace-output.txt`

```bash
strace ls /tmp 2>&1 > ~/strace-output.txt
```

Note: `strace` outputs to stderr, so we redirect with `2>&1`.
