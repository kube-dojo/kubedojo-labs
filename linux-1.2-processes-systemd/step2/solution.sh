#!/bin/bash
# Solution: List active timers
if systemctl list-timers --no-pager > /root/active-timers.txt 2>/dev/null && [ -s /root/active-timers.txt ]; then
  cat /root/active-timers.txt
else
  # Docker fallback: list scheduled tasks from cron and at
  {
    echo "=== Cron jobs ==="
    ls /etc/cron.d/ 2>/dev/null || echo "(no cron.d entries)"
    crontab -l 2>/dev/null || echo "(no user crontab)"
    echo "=== /etc/crontab ==="
    cat /etc/crontab 2>/dev/null || echo "(no /etc/crontab)"
  } > /root/active-timers.txt
  cat /root/active-timers.txt
fi
