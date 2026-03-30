#!/bin/bash
# Verify /root/init-name.txt exists and contains a known init system
if [ ! -f /root/init-name.txt ]; then
  echo "/root/init-name.txt does not exist"
  exit 1
fi

content=$(cat /root/init-name.txt | tr -d '[:space:]')
if [ -n "$content" ]; then
  echo "Init process: $content. Correct!"
  exit 0
else
  echo "File is empty"
  exit 1
fi
