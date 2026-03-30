#!/bin/bash
# Verify that /root/nameservers.txt exists and contains an IP
if [ ! -f /root/nameservers.txt ]; then
  echo "FAIL: /root/nameservers.txt does not exist"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' /root/nameservers.txt; then
  echo "PASS: File contains nameserver IP(s)"
  exit 0
else
  echo "FAIL: /root/nameservers.txt does not contain an IP address"
  exit 1
fi
