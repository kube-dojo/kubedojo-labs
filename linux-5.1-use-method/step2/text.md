# CPU Analysis with mpstat and pidstat

Now let's dig deeper into CPU utilization using `mpstat` and `pidstat` from the `sysstat` package.

## mpstat — Per-CPU Statistics

`mpstat` shows utilization for each CPU core:

```bash
mpstat -P ALL 1 1
```

Key columns:
- `%usr` — user-level CPU usage
- `%sys` — kernel-level CPU usage
- `%iowait` — waiting for I/O
- `%idle` — idle time (100% - idle = utilization)

## pidstat — Per-Process CPU

`pidstat` shows CPU usage per process:

```bash
pidstat 1 3
```

A CPU-intensive process has been started in the background.

## Your Task

1. Use `pidstat` or `ps` to identify the process consuming the most CPU
2. Save its PID to `~/cpu-hog.txt`

**Hint:**
```bash
# Find the top CPU consumer (excluding pidstat itself)
ps aux --sort=-%cpu | awk 'NR==2 {print $2}' > ~/cpu-hog.txt
```
