#!/bin/bash
# Solution: System maintenance
sudo apt-get clean
sudo apt-get update -qq 2>/dev/null
{
  echo "Cache size after cleaning:"
  du -sh /var/cache/apt/
  echo ""
  echo "Upgradable packages:"
  apt list --upgradable 2>/dev/null || echo "none"
} > "$HOME"/maintenance.txt
cat "$HOME"/maintenance.txt
