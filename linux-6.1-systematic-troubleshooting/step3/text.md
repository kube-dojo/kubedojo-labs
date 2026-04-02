# Check Logs

Logs are your best friend when troubleshooting. Linux stores logs in `/var/log/` and through `journalctl`.

## Log Locations

| File | Contents |
|------|----------|
| `/var/log/syslog` | General system messages |
| `/var/log/auth.log` | Authentication events |
| `/var/log/kern.log` | Kernel messages |
| `/var/log/dmesg` | Boot-time kernel messages |

## Searching for Errors

```bash
# Search syslog for errors
grep -i "error\|critical\|fail" /var/log/syslog

# Using journalctl
journalctl -p err --no-pager

# Recent errors only
journalctl -p err --since "1 hour ago" --no-pager
```

## Your Task

1. Search system logs for ERROR and CRITICAL entries
2. Count the total number of such entries
3. Save the count to `~/error-count.txt`

**Hint:**
```bash
grep -ci "ERROR\|CRITICAL" /var/log/syslog > ~/error-count.txt
```
