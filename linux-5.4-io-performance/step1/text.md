# Disk I/O Statistics

## iostat

`iostat` (from `sysstat`) shows CPU and device I/O statistics:

```bash
iostat -xz 1 1
```

Key columns:
| Column | Meaning |
|--------|---------|
| `r/s` | Reads per second |
| `w/s` | Writes per second |
| `rkB/s` | Read KB per second |
| `wkB/s` | Write KB per second |
| `await` | Average I/O wait time (ms) |
| `%util` | Device utilization percentage |

**Rules of thumb:**
- `%util > 60%` — device is busy
- `await > 10ms` for SSD — possible issue
- `await > 50ms` for HDD — possible issue

## Your Task

1. Run `iostat -xz 1 1` and save the full output to `/root/iostat.txt`

```bash
iostat -xz 1 1 > /root/iostat.txt
```
