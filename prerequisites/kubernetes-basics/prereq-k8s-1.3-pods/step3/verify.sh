#!/bin/bash
# Verify file contains an IP address
[ -f /root/web-pod-ip.txt ] || exit 1
IP=$(cat /root/web-pod-ip.txt | tr -d '[:space:]')
[ -z "$IP" ] && exit 1
echo "$IP" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' || exit 1
exit 0
