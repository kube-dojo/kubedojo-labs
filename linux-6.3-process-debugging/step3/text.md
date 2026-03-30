# ltrace — Library Call Tracing

While `strace` traces kernel-level system calls, `ltrace` traces calls to shared library functions (like `malloc`, `printf`, `strcmp`).

## Basic Usage

```bash
# Trace library calls
ltrace ls /tmp 2>&1 | head -20

# Count library calls
ltrace -c ls /tmp 2>&1
```

## Common Library Calls

| Function | Library | Purpose |
|----------|---------|---------|
| `malloc` | libc | Allocate memory |
| `free` | libc | Free memory |
| `strcmp` | libc | Compare strings |
| `printf` | libc | Formatted output |
| `fopen` | libc | Open file (high-level) |

## Your Task

1. Run `ltrace` on a command (e.g., `ls /tmp`)
2. Save the library call output to `/root/ltrace-output.txt`

```bash
ltrace ls /tmp 2> /root/ltrace-output.txt
```

Note: Like strace, ltrace outputs to stderr.
