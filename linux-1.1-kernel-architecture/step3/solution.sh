#!/bin/bash
# Solution: Read ip_forward kernel parameter
if command -v sysctl > /dev/null 2>&1; then
  sysctl -n net.ipv4.ip_forward > /root/ip-forward.txt 2>/dev/null
fi
# Fallback: read directly from /proc
if [ ! -s /root/ip-forward.txt ]; then
  cat /proc/sys/net/ipv4/ip_forward > /root/ip-forward.txt 2>/dev/null
fi
cat /root/ip-forward.txt
