#!/bin/bash
if [ ! -f /root/port-scan.txt ]; then
  echo "FAIL: /root/port-scan.txt not found"
  exit 1
fi

if grep -q "80" /root/port-scan.txt; then
  echo "PASS: port-scan.txt shows port 80"
  exit 0
else
  echo "FAIL: port-scan.txt should contain port 80 (nginx)"
  exit 1
fi
