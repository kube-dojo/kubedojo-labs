#!/bin/bash
if [ ! -f /root/events.txt ]; then
  echo "FAIL: /root/events.txt not found"
  exit 1
fi
if [ ! -f /root/warning-events.txt ]; then
  echo "FAIL: /root/warning-events.txt not found"
  exit 1
fi
echo "PASS"
exit 0
