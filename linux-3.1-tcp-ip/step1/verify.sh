#!/bin/bash
# Verify that /root/all-ips.txt exists and contains at least one IP address
if [ ! -f /root/all-ips.txt ]; then
  echo "FAIL: /root/all-ips.txt does not exist"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' /root/all-ips.txt; then
  echo "PASS: File contains IP address(es)"
  exit 0
else
  echo "FAIL: /root/all-ips.txt does not contain any IP addresses"
  exit 1
fi
