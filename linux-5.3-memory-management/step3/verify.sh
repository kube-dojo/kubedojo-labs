#!/bin/bash
if [ ! -f /root/oom-candidate.txt ]; then
  echo "FAIL: /root/oom-candidate.txt not found"
  exit 1
fi

if grep -q "PID:" /root/oom-candidate.txt && grep -q "Score:" /root/oom-candidate.txt; then
  echo "PASS: File contains PID and Score"
  exit 0
else
  echo "FAIL: File should contain PID and Score entries"
  exit 1
fi
