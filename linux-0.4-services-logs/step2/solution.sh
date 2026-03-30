#!/bin/bash
# Solution: Get nginx journal/log output
if journalctl -u nginx -n 20 --no-pager > /root/nginx-journal.txt 2>/dev/null && [ -s /root/nginx-journal.txt ]; then
  cat /root/nginx-journal.txt
else
  # Docker fallback: use nginx log files
  {
    echo "=== nginx access log ==="
    tail -20 /var/log/nginx/access.log 2>/dev/null || echo "(empty)"
    echo "=== nginx error log ==="
    tail -20 /var/log/nginx/error.log 2>/dev/null || echo "(empty)"
  } > /root/nginx-journal.txt
  # Ensure file is non-empty
  if [ ! -s /root/nginx-journal.txt ]; then
    echo "No nginx log entries found yet" > /root/nginx-journal.txt
  fi
  cat /root/nginx-journal.txt
fi
