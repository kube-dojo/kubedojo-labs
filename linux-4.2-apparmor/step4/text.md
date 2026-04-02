# Profile Debugging

When AppArmor denies an action, it writes a log entry. These logs are essential for developing profiles — you start in complain mode, run the application normally, then use the logs to build allow rules.

## Where Denials Are Logged

| Location | Notes |
|----------|-------|
| `/var/log/syslog` | Primary log on Ubuntu |
| `/var/log/kern.log` | Kernel messages |
| `dmesg` | Kernel ring buffer |
| `journalctl -k` | systemd journal kernel messages |

## Log Entry Format

```
apparmor="DENIED" operation="open" profile="/usr/bin/curl"
name="/some/path" pid=1234 comm="curl" requested_mask="r" denied_mask="r"
```

## Debugging Workflow

1. Switch profile to complain: `aa-complain /etc/apparmor.d/usr.bin.curl`
2. Run the program normally
3. Check logs: `dmesg | grep apparmor` or `grep apparmor /var/log/syslog`
4. Use `aa-logprof` to interactively update the profile based on denials

## Task

1. Switch the curl profile to **complain** mode: `aa-complain /etc/apparmor.d/usr.bin.curl`
2. Run `curl --version` (or `curl http://localhost` if a server is running)
3. Check for AppArmor log entries: `dmesg | grep -i apparmor` or `grep -i apparmor /var/log/syslog`
4. Save any AppArmor-related log entries to `~/apparmor-logs.txt`
   - If no denial entries are found (common in complain mode with permissive profile), save the output of `aa-status` and note that no denials occurred

<details>
<summary>Refer to: aa-logprof(8), aa-complain(8)</summary>
See <code>man aa-logprof</code> for interactive profile refinement. The <code>dmesg</code> command shows kernel messages including AppArmor denials.
</details>
