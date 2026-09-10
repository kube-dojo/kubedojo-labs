#!/bin/bash
# Solution: Find top 5 IPs
awk '{print $1}' "$HOME"/access.log | sort | uniq -c | sort -rn | head -5 > "$HOME"/top-ips.txt
cat "$HOME"/top-ips.txt
