#!/bin/bash
# Verify load-avg.txt contains numbers
if [ ! -f /root/load-avg.txt ]; then
  echo "FAIL: /root/load-avg.txt not found"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+' /root/load-avg.txt; then
  echo "PASS: load-avg.txt contains load average numbers"
  exit 0
else
  echo "FAIL: /root/load-avg.txt does not contain valid numbers"
  exit 1
fi
