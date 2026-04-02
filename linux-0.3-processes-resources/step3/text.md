## Step 3: Resource Monitoring

Knowing how to check memory, disk, and CPU usage is critical for troubleshooting.

### Memory

```bash
free -m              # memory in megabytes
free -h              # human-readable
```

Key columns: **total**, **used**, **free**, **available** (what's actually usable).

### Disk

```bash
df -h                # disk space by filesystem
du -sh /var/log      # size of a directory
```

### CPU and I/O

```bash
vmstat 1 3           # 3 snapshots, 1 second apart
```

### Your task

1. Save the output of `free -m` to `~/memory.txt`
2. Save the disk usage of `/` (just the line for `/`) to `~/disk.txt`

<details>
<summary>Hint</summary>

```bash
free -m > ~/memory.txt
df -h / | tail -1 > ~/disk.txt
```

The `tail -1` grabs only the data line, skipping the header.
</details>
