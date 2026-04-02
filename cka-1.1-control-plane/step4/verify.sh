#!/bin/bash
FILE="/root/cp-health.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

S_RUNNING=$(grep "scheduler" "$FILE" | grep -i "Running" | wc -l)
C_RUNNING=$(grep "controller-manager" "$FILE" | grep -i "Running" | wc -l)

if [ "$S_RUNNING" -ge 1 ] && [ "$C_RUNNING" -ge 1 ]; then
  echo "PASS: Scheduler and Controller Manager are confirmed Running"
  exit 0
else
  echo "FAIL: File must show both scheduler and controller-manager in Running state"
  exit 1
fi