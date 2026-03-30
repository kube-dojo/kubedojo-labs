#!/bin/bash
if [ ! -f /root/service-cidr.txt ]; then
  echo "FAIL: /root/service-cidr.txt does not exist"
  exit 1
fi

# Check for a CIDR notation (contains / and digits)
if grep -qE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+" /root/service-cidr.txt; then
  echo "PASS: File contains a CIDR range"
  exit 0
else
  echo "FAIL: File should contain a CIDR range (e.g., 10.96.0.0/12)"
  exit 1
fi
