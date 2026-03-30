# Scheduling Policies

Linux supports several scheduling policies:

| Policy | Type | Description |
|--------|------|-------------|
| `SCHED_OTHER` | Normal | Default time-sharing policy (CFS) |
| `SCHED_FIFO` | Real-time | First-in, first-out; runs until it yields |
| `SCHED_RR` | Real-time | Round-robin with time quantum |
| `SCHED_BATCH` | Normal | For batch/CPU-intensive workloads |
| `SCHED_IDLE` | Normal | Very low priority |

## Inspecting Scheduling Policy

Use `chrt` to view a process's scheduling policy:

```bash
chrt -p <PID>
```

You can also read it from the proc filesystem:

```bash
cat /proc/<PID>/sched | head -5
```

## Your Task

1. Check the scheduling policy of PID 1 (the init process)
2. Save the output to `/root/sched-policy.txt`

```bash
chrt -p 1 > /root/sched-policy.txt
```
