#!/bin/bash
# Verify /root/nofile-limit.txt contains a number
if [ ! -f /root/nofile-limit.txt ]; then
  echo "/root/nofile-limit.txt does not exist"
  exit 1
fi

content=$(cat /root/nofile-limit.txt | tr -d '[:space:]')
if [[ "$content" =~ ^[0-9]+$ ]]; then
  echo "Open files limit: $content"
  exit 0
else
  echo "File should contain a number, got: '$content'"
  exit 1
fi
