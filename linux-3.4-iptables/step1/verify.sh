#!/bin/bash
# Verify that /root/iptables-rules.txt exists and contains chain info
if [ ! -f /root/iptables-rules.txt ]; then
  echo "FAIL: /root/iptables-rules.txt does not exist"
  exit 1
fi

if grep -qiE "Chain (INPUT|FORWARD|OUTPUT)" /root/iptables-rules.txt; then
  echo "PASS: File contains iptables chain information"
  exit 0
else
  echo "FAIL: /root/iptables-rules.txt does not contain expected chain information"
  exit 1
fi
