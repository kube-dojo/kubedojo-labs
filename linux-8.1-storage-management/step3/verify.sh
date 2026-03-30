#!/bin/bash
if [ ! -f /root/disk-usage.txt ]; then
  echo "FAIL: /root/disk-usage.txt not found"
  exit 1
fi

LINES=$(wc -l < /root/disk-usage.txt)
if [ "$LINES" -ge 10 ]; then
  echo "PASS: disk-usage.txt has $LINES lines"
  exit 0
else
  echo "FAIL: Expected at least 10 lines, got $LINES"
  exit 1
fi
