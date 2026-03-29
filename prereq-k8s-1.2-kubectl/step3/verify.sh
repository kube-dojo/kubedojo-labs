#!/bin/bash
# Verify file contains an IP address
[ -f /root/node-ip.txt ] || exit 1
IP=$(cat /root/node-ip.txt | tr -d '[:space:]')
[ -z "$IP" ] && exit 1
# Check it looks like an IP address (basic pattern)
echo "$IP" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' || exit 1
exit 0
