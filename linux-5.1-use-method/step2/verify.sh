#!/bin/bash
# Verify cpu-hog.txt contains a PID
if [ ! -f /root/cpu-hog.txt ]; then
  echo "FAIL: /root/cpu-hog.txt not found"
  exit 1
fi

PID=$(cat /root/cpu-hog.txt | tr -d '[:space:]')
if [[ "$PID" =~ ^[0-9]+$ ]] && [ "$PID" -gt 0 ]; then
  echo "PASS: cpu-hog.txt contains PID $PID"
  exit 0
else
  echo "FAIL: /root/cpu-hog.txt does not contain a valid PID"
  exit 1
fi
