#!/bin/bash
# Solution: Add static route
GW=$(ip route | grep default | awk '{print $3}' | head -1)
if [ -n "$GW" ]; then
  ip route add 192.168.100.0/24 via "$GW" 2>/dev/null || true
else
  # If no default gateway, route via dummy0
  ip route add 192.168.100.0/24 dev dummy0 2>/dev/null || true
fi
ip route show > /root/routes.txt
cat /root/routes.txt
