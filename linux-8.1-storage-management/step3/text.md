# Disk Usage Analysis

## du — Disk Usage by Directory

```bash
# Top-level directories, sorted by size
du -sh /* 2>/dev/null | sort -rh | head -10

# Specific directory, one level deep
du -sh /var/* 2>/dev/null | sort -rh | head -10

# Total for a directory
du -sh /var/log
```

## df — Filesystem Usage

```bash
# Human-readable
df -h

# Inodes
df -i
```

## Your Task

Find the top 10 largest directories under `/` (one level deep) and save to `/root/disk-usage.txt`.

Each line should show size and directory name.

**Hint:**
```bash
du -sh /* 2>/dev/null | sort -rh | head -10 > /root/disk-usage.txt
```
