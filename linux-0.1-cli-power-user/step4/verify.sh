#!/bin/bash
# Verify /root/total-lines.txt exists and contains a number
if [ ! -f /root/total-lines.txt ]; then
  echo "/root/total-lines.txt does not exist"
  exit 1
fi

count=$(cat /root/total-lines.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Total lines: $count. Well done!"
  exit 0
else
  echo "File should contain a number, got: '$count'"
  exit 1
fi
