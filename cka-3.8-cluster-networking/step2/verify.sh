#!/bin/bash
# Verify: service-ip.txt contains a valid IP
if [ -f /root/service-ip.txt ]; then
  IP=$(cat /root/service-ip.txt)
  echo "$IP" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' && exit 0
fi
exit 1
