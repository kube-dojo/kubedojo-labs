#!/bin/bash
# Solution: Count error log entries
grep -ci "ERROR\|CRITICAL" /var/log/syslog > /root/error-count.txt
echo "Error count: $(cat /root/error-count.txt)"
