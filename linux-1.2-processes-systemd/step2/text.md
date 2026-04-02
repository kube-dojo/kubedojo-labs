## Step 2: systemd Unit Types

systemd doesn't just manage services. It manages many types of **units**:

| Type | Extension | Purpose |
|------|-----------|---------|
| Service | `.service` | Daemons and one-shot tasks |
| Timer | `.timer` | Scheduled execution (replaces cron) |
| Socket | `.socket` | Socket-based activation |
| Target | `.target` | Group of units (like runlevels) |
| Mount | `.mount` | Filesystem mounts |
| Path | `.path` | File/directory monitoring |

### Listing units by type

```bash
systemctl list-units --type=service    # all active services
systemctl list-units --type=timer      # all active timers
systemctl list-units --type=target     # all active targets
```

### Timers

Timers are systemd's replacement for cron jobs:

```bash
systemctl list-timers                  # show all timers with next run time
```

### Your task

List all active timers on the system and save the output to `~/active-timers.txt`.

<details>
<summary>Hint</summary>

```bash
systemctl list-timers --no-pager > ~/active-timers.txt
```
</details>
