#!/bin/bash
# Solution: Extract load average
uptime | awk -F'load average: ' '{print $2}' | tr ',' ' ' > /root/load-avg.txt
cat /root/load-avg.txt
