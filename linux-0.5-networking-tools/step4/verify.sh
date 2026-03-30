#!/bin/bash
# Verify /root/listening-ports.txt contains port info
if [ ! -f /root/listening-ports.txt ]; then
  echo "/root/listening-ports.txt does not exist"
  exit 1
fi

# Check for port 22 or 80 in various formats
if grep -qE "(:(22|80)\b|:80 |:22 )" /root/listening-ports.txt; then
  echo "Listening ports captured!"
  exit 0
fi

# Docker may not have SSH — accept any listening port output with State header
if grep -qiE "(LISTEN|State)" /root/listening-ports.txt; then
  echo "Listening ports captured!"
  exit 0
fi

echo "Expected to find port 22 or 80 in the output"
exit 1
