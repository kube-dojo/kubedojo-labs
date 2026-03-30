#!/bin/bash
# Verify that /root/iptables-backup.txt exists and contains iptables rules
if [ ! -f /root/iptables-backup.txt ]; then
  echo "FAIL: /root/iptables-backup.txt does not exist"
  exit 1
fi

# Check for filter table content (either -A rules or *filter marker)
if grep -qE "(-A INPUT|\*filter)" /root/iptables-backup.txt; then
  echo "PASS: File contains iptables rules"
  exit 0
else
  echo "FAIL: /root/iptables-backup.txt does not contain expected iptables rules"
  exit 1
fi
