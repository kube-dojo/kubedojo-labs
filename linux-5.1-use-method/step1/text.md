# Identify Bottlenecks with the USE Method

The USE method starts with a quick system overview. The first tools to reach for are `uptime`, `vmstat`, `free`, and `df`.

## Load Average

The `uptime` command shows the system load average over 1, 5, and 15 minutes. Load average represents the number of processes waiting for CPU time. If the load average exceeds the number of CPUs, the system is CPU-saturated.

```bash
uptime
```

## Virtual Memory Statistics

`vmstat` provides a snapshot of CPU, memory, I/O, and scheduling:

```bash
vmstat 1 3
```

This runs 3 samples at 1-second intervals. Key columns:
- `r` — processes waiting for CPU (saturation)
- `b` — processes in uninterruptible sleep (I/O blocked)
- `us` — user CPU time (utilization)
- `sy` — system CPU time
- `wa` — I/O wait time
- `si/so` — swap in/out (memory saturation)

## Your Task

1. Run `uptime` and `vmstat 1 3`
2. Save the load average values (the three numbers) to `/root/load-avg.txt`

For example, if uptime shows `load average: 0.15, 0.10, 0.05`, your file should contain:

```
0.15 0.10 0.05
```

**Hint:** You can extract the load average with:
```bash
uptime | awk -F'load average: ' '{print $2}' | tr ',' ' ' > /root/load-avg.txt
```
