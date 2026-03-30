#!/bin/bash
# Verify that /root/gateway.txt exists and contains an IP address
if [ ! -f /root/gateway.txt ]; then
  echo "FAIL: /root/gateway.txt does not exist"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' /root/gateway.txt; then
  echo "PASS: File contains a gateway IP"
  exit 0
else
  echo "FAIL: /root/gateway.txt does not contain an IP address"
  exit 1
fi
