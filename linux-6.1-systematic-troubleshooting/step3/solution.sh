#!/bin/bash
# Solution: Count error log entries (check multiple log locations)
COUNT=0
for logfile in /var/log/syslog /var/log/messages /var/log/*.log; do
  if [ -f "$logfile" ]; then
    C=$(grep -ci "ERROR\|CRITICAL\|FATAL" "$logfile" 2>/dev/null || echo 0)
    COUNT=$((COUNT + C))
  fi
done
echo "$COUNT" > /root/error-count.txt
echo "Error count: $COUNT"
