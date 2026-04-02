# CPU Affinity with taskset

CPU affinity determines which CPU cores a process can run on. By pinning a process to specific cores, you can:

- Improve cache locality
- Isolate workloads from each other
- Reserve cores for critical processes

## Using taskset

Set affinity when launching a process:

```bash
# Pin to CPU 0 only
taskset -c 0 <command>

# Pin to CPUs 0 and 1
taskset -c 0,1 <command>
```

Check affinity of a running process:

```bash
taskset -p <PID>
```

The output shows a hexadecimal affinity mask. `1` means CPU 0, `3` means CPUs 0-1, `f` means CPUs 0-3.

## Your Task

1. Start a long-running process pinned to CPU 0:
   ```bash
   taskset -c 0 sleep 300 &
   ```
2. Save its PID to `~/affinity-pid.txt`

**Hint:** After running the backgrounded command, `$!` gives you the PID of the last background process.
