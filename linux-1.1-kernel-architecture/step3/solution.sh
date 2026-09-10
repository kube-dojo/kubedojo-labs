#!/bin/bash
# Solution: Read ip_forward kernel parameter
if command -v sysctl > /dev/null 2>&1; then
  sysctl -n net.ipv4.ip_forward > "$HOME"/ip-forward.txt 2>/dev/null
fi
# Fallback: read directly from /proc
if [ ! -s "$HOME"/ip-forward.txt ]; then
  cat /proc/sys/net/ipv4/ip_forward > "$HOME"/ip-forward.txt 2>/dev/null
fi
cat "$HOME"/ip-forward.txt
