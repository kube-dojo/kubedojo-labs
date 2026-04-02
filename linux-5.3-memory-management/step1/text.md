# Memory Statistics

## free — Quick Overview

```bash
free -m
```

Key values:
- **total** — physical RAM installed
- **used** — memory in use (excluding buffers/cache)
- **free** — truly unused memory
- **available** — memory available for new applications (free + reclaimable cache)

## /proc/meminfo — Detailed View

```bash
cat /proc/meminfo
```

Important fields: `MemTotal`, `MemFree`, `MemAvailable`, `Buffers`, `Cached`, `SwapTotal`, `SwapFree`.

## vmstat — Live Monitoring

```bash
vmstat 1 3
```

Memory columns: `swpd` (swap used), `free`, `buff` (buffers), `cache`.

## Your Task

1. Extract the following three values (in MB) and save them to `~/mem-stats.txt`:
   - Total memory
   - Used memory
   - Available memory

Format (one value per line):
```
Total: <value>MB
Used: <value>MB
Available: <value>MB
```

**Hint:**
```bash
free -m | awk '/^Mem:/ {printf "Total: %sMB\nUsed: %sMB\nAvailable: %sMB\n", $2, $3, $7}'
```
