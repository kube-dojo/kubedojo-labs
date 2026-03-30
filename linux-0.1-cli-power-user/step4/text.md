## Step 4: Productivity Tricks

Power users combine `find`, `xargs`, and other tools to automate tasks that would take dozens of manual commands.

### Key tools

- **`xargs`** — build and execute commands from stdin
- **`find -exec`** — run a command on each found file
- **`watch`** — re-run a command every N seconds
- **`wc -l`** — count lines in files

### Examples

```bash
# Delete all .tmp files (xargs)
find /tmp -name "*.tmp" | xargs rm -f

# Same thing with find -exec
find /tmp -name "*.tmp" -exec rm -f {} \;

# Watch disk usage every 2 seconds
watch -n 2 df -h
```

### Your task

Find all `.log` files in `/var/log`, count the total number of lines across ALL of them combined, and save that total to `/root/total-lines.txt`.

The file should contain a single number.

<details>
<summary>Hint</summary>

Use `find` to locate log files, `xargs` to pass them to `wc -l`, then extract the total:

```bash
find /var/log -name "*.log" -type f 2>/dev/null | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}' > /root/total-lines.txt
```

If there's only one file, `wc -l` won't print a "total" line, so an alternative approach:

```bash
find /var/log -name "*.log" -type f 2>/dev/null | xargs cat 2>/dev/null | wc -l > /root/total-lines.txt
```
</details>
