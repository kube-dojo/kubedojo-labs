#!/bin/bash
# Solution: System maintenance
apt-get clean
apt-get update -qq 2>/dev/null
{
  echo "Cache size after cleaning:"
  du -sh /var/cache/apt/
  echo ""
  echo "Upgradable packages:"
  apt list --upgradable 2>/dev/null || echo "none"
} > /root/maintenance.txt
cat /root/maintenance.txt
