#!/bin/bash
# Verify /root/conf-count.txt exists and contains a number > 0
if [ ! -f /root/conf-count.txt ]; then
  echo "/root/conf-count.txt does not exist"
  exit 1
fi

count=$(cat /root/conf-count.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]] && [ "$count" -gt 0 ]; then
  echo "Found $count .conf files. Well done!"
  exit 0
else
  echo "File should contain a number greater than 0, got: '$count'"
  exit 1
fi
