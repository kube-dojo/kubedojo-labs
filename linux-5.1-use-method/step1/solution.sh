#!/bin/bash
# Solution: Extract load average
uptime | awk -F'load average: ' '{print $2}' | tr ',' ' ' > "$HOME"/load-avg.txt
cat "$HOME"/load-avg.txt
