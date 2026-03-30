#!/bin/bash
if [ ! -f /root/app-logs.txt ]; then
  echo "FAIL: /root/app-logs.txt not found"
  exit 1
fi
LINES=$(wc -l < /root/app-logs.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: app-logs.txt should have at least 5 lines"
  exit 1
fi
if [ ! -f /root/log-line-count.txt ]; then
  echo "FAIL: /root/log-line-count.txt not found"
  exit 1
fi
echo "PASS"
exit 0
