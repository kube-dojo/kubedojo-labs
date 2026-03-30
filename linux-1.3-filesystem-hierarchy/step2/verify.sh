#!/bin/bash
# Verify /root/large-files-count.txt contains a number
if [ ! -f /root/large-files-count.txt ]; then
  echo "/root/large-files-count.txt does not exist"
  exit 1
fi

count=$(cat /root/large-files-count.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Found $count files larger than 1MB in /usr."
  exit 0
else
  echo "File should contain a number, got: '$count'"
  exit 1
fi
