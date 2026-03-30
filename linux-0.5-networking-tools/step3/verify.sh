#!/bin/bash
# Verify /root/port-check.txt contains "open" or "succeeded"
if [ ! -f /root/port-check.txt ]; then
  echo "/root/port-check.txt does not exist"
  exit 1
fi

content=$(cat /root/port-check.txt)
if echo "$content" | grep -qiE "(open|succeeded|connected)"; then
  echo "Port check passed!"
  exit 0
else
  echo "File should contain 'open' or 'succeeded', got: '$content'"
  exit 1
fi
