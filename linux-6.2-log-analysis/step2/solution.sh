#!/bin/bash
# Solution: Count 5xx errors
awk '$9 ~ /^5/' /root/access.log | wc -l > /root/5xx-count.txt
echo "5xx error count: $(cat /root/5xx-count.txt)"
