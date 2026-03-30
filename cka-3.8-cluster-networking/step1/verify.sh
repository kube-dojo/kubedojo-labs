#!/bin/bash
# Verify: pod-ips.txt exists with valid IPs
if [ -f /root/pod-ips.txt ]; then
  LINE_COUNT=$(cat /root/pod-ips.txt | grep -cE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')
  [ "$LINE_COUNT" -ge 3 ] && exit 0
fi
exit 1
