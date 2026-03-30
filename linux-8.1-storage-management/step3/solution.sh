#!/bin/bash
# Solution: Disk usage analysis
du -sh /* 2>/dev/null | sort -rh | head -10 > /root/disk-usage.txt
cat /root/disk-usage.txt
