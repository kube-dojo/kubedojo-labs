#!/bin/bash
if [ ! -f /root/top-ips.txt ]; then
  echo "FAIL: /root/top-ips.txt not found"
  exit 1
fi

LINES=$(wc -l < /root/top-ips.txt)
if [ "$LINES" -eq 5 ]; then
  echo "PASS: top-ips.txt has exactly 5 lines"
  exit 0
else
  echo "FAIL: Expected 5 lines, got $LINES"
  exit 1
fi
