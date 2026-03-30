## Step 3: Disk and Mount Management

Understanding how filesystems are mounted is critical for storage troubleshooting.

### View disk usage

```bash
df -h                    # filesystem disk usage (human-readable)
df -T                    # include filesystem type
du -sh /var/log          # size of a specific directory
```

### View mounts

```bash
mount                    # all current mounts
findmnt                  # tree view of mounts
findmnt -t ext4          # only ext4 mounts
lsblk                    # block devices in tree format
```

### View filesystem type

```bash
df -T /                  # shows type for root filesystem
findmnt -n -o FSTYPE /   # just the type for /
```

### Your task

Find the filesystem type of `/` (the root filesystem) and save it to `/root/root-fstype.txt`.

The file should contain just the type (e.g., `ext4`, `xfs`, or `overlay`).

<details>
<summary>Hint</summary>

```bash
findmnt -n -o FSTYPE / > /root/root-fstype.txt
```

Or:

```bash
df -T / | tail -1 | awk '{print $2}' > /root/root-fstype.txt
```
</details>
