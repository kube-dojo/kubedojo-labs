#!/bin/bash
# Solution: Count total lines in all .log files under /var/log
find /var/log -name "*.log" -type f 2>/dev/null | xargs cat 2>/dev/null | wc -l > /root/total-lines.txt
cat /root/total-lines.txt
