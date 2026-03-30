#!/bin/bash
if [ ! -f /root/recent-logs.txt ]; then
  echo "FAIL: /root/recent-logs.txt not found"
  exit 1
fi

if [ -s /root/recent-logs.txt ]; then
  echo "PASS: recent-logs.txt exists and has content"
  exit 0
else
  echo "FAIL: recent-logs.txt is empty"
  exit 1
fi
