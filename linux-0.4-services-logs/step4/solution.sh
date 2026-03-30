#!/bin/bash
# Solution: Count error lines in logs
if journalctl --no-pager > /dev/null 2>&1; then
  journalctl --no-pager 2>/dev/null | grep -ic "error" > /root/error-count.txt || echo "0" > /root/error-count.txt
else
  # Docker fallback: search /var/log for errors
  count=$(grep -ric "error" /var/log/ 2>/dev/null | awk -F: '{s+=$2} END {print s+0}')
  echo "$count" > /root/error-count.txt
fi
cat /root/error-count.txt
