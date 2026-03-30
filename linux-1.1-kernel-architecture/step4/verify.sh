#!/bin/bash
# Verify /root/dmesg-tail.txt exists and has content
if [ ! -f /root/dmesg-tail.txt ]; then
  echo "/root/dmesg-tail.txt does not exist"
  exit 1
fi

if [ ! -s /root/dmesg-tail.txt ]; then
  echo "/root/dmesg-tail.txt is empty"
  exit 1
fi

lines=$(wc -l < /root/dmesg-tail.txt | tr -d '[:space:]')
echo "Captured $lines lines of kernel messages."
exit 0
