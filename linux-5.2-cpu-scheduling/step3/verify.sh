#!/bin/bash
if [ ! -f /root/nice-process.txt ]; then
  echo "FAIL: /root/nice-process.txt not found"
  exit 1
fi

if grep -qi "nice" /root/nice-process.txt && grep -q "\-10" /root/nice-process.txt; then
  echo "PASS: File contains nice value -10"
  exit 0
else
  echo "FAIL: File should contain the nice value -10"
  exit 1
fi
