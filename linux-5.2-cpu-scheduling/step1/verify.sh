#!/bin/bash
if [ ! -f /root/sched-policy.txt ]; then
  echo "FAIL: /root/sched-policy.txt not found"
  exit 1
fi

if [ -s /root/sched-policy.txt ]; then
  echo "PASS: sched-policy.txt has content"
  exit 0
else
  echo "FAIL: sched-policy.txt is empty"
  exit 1
fi
