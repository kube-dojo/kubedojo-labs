#!/bin/bash
# Verify /root/error-count.txt contains a number
if [ ! -f /root/error-count.txt ]; then
  echo "/root/error-count.txt does not exist"
  exit 1
fi

count=$(cat /root/error-count.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Error count: $count. Analysis complete!"
  exit 0
else
  echo "File should contain a number, got: '$count'"
  exit 1
fi
