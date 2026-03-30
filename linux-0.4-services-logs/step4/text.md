## Step 4: Log Rotation and Analysis

Production systems generate massive amounts of logs. **logrotate** prevents disks from filling up. Log analysis helps you find problems.

### logrotate

Configuration lives in `/etc/logrotate.d/`. Each file defines rotation rules:

```
/var/log/nginx/*.log {
    daily
    missingok
    rotate 14
    compress
    notifempty
}
```

View the main config:

```bash
cat /etc/logrotate.conf
```

### Log analysis patterns

Common analysis tasks:

```bash
# Count error lines
grep -c "error" /var/log/syslog

# Errors per hour
grep "error" /var/log/syslog | awk '{print $1, $2, $3}' | cut -d: -f1 | sort | uniq -c

# Top talkers in access log
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -rn | head -5
```

### Your task

Count lines containing "error" or "ERROR" in the system journal (or `/var/log/syslog`) and save the count to `/root/error-count.txt`.

A count of 0 is fine — what matters is that you know how to look.

<details>
<summary>Hint</summary>

Using journalctl:

```bash
journalctl --no-pager | grep -ic "error" > /root/error-count.txt
```

Or using syslog:

```bash
grep -ic "error" /var/log/syslog > /root/error-count.txt 2>/dev/null || echo "0" > /root/error-count.txt
```
</details>
