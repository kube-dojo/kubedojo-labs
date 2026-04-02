## Step 2: Journal and Logging

**journald** collects logs from all systemd services, the kernel, and more. It replaces the old syslog for most use cases.

### Key commands

```bash
journalctl                          # all logs (paged)
journalctl -u nginx                 # logs for a specific service
journalctl -u nginx --no-pager      # without paging
journalctl -u nginx -n 20           # last 20 lines
journalctl -f                       # follow (like tail -f)
journalctl --since "1 hour ago"     # time-based filter
journalctl -p err                   # only errors and above
```

### Traditional log files

Many services also write to `/var/log/`:

```bash
ls /var/log/
```

### Your task

Get the last 20 lines of nginx logs from the journal and save them to `~/nginx-journal.txt`.

<details>
<summary>Hint</summary>

```bash
journalctl -u nginx -n 20 --no-pager > ~/nginx-journal.txt
```

If the journal has no nginx entries yet, you might need to restart nginx first or use the log file directly:

```bash
journalctl -u nginx -n 20 --no-pager > ~/nginx-journal.txt
# If empty, try:
# tail -20 /var/log/nginx/access.log /var/log/nginx/error.log > ~/nginx-journal.txt
```
</details>
