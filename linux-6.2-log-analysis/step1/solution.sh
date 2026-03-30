#!/bin/bash
# Solution: Find top 5 IPs
awk '{print $1}' /root/access.log | sort | uniq -c | sort -rn | head -5 > /root/top-ips.txt
cat /root/top-ips.txt
