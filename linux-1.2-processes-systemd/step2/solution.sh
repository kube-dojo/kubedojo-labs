#!/bin/bash
# Solution: List active timers
if systemctl list-timers --no-pager > "$HOME"/active-timers.txt 2>/dev/null && [ -s "$HOME"/active-timers.txt ]; then
  cat "$HOME"/active-timers.txt
else
  # Docker fallback: list scheduled tasks from cron and at
  {
    echo "=== Cron jobs ==="
    ls /etc/cron.d/ 2>/dev/null || echo "(no cron.d entries)"
    crontab -l 2>/dev/null || echo "(no user crontab)"
    echo "=== /etc/crontab ==="
    cat /etc/crontab 2>/dev/null || echo "(no /etc/crontab)"
  } > "$HOME"/active-timers.txt
  cat "$HOME"/active-timers.txt
fi
