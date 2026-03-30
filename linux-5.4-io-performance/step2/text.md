# I/O Schedulers

The I/O scheduler determines the order in which I/O requests are sent to the disk.

## Common Schedulers

| Scheduler | Best For |
|-----------|----------|
| `mq-deadline` | Databases, latency-sensitive workloads |
| `bfq` | Interactive desktops, fairness |
| `kyber` | Fast NVMe devices |
| `none` | NVMe SSDs (no scheduling needed) |

## Checking the Current Scheduler

For a device (e.g., `sda` or `vda`):

```bash
cat /sys/block/<device>/queue/scheduler
```

The active scheduler is shown in brackets, e.g., `[mq-deadline] kyber bfq none`.

## Your Task

1. Find the root disk device name using `lsblk`
2. Check its I/O scheduler
3. Save the scheduler name to `/root/io-scheduler.txt`

**Hint:**
```bash
# Find root device
DEVICE=$(lsblk -no NAME,MOUNTPOINT | awk '$2=="/" {print $1}' | sed 's/[^a-z]//g')
# If that doesn't work, try:
DEVICE=$(lsblk -dno NAME | head -1)
cat /sys/block/$DEVICE/queue/scheduler | grep -oP '\[\K[^\]]+' > /root/io-scheduler.txt
```
