#!/bin/bash
# Verify both files exist with content
if [ ! -f /root/memory.txt ]; then
  echo "/root/memory.txt does not exist"
  exit 1
fi

if [ ! -s /root/memory.txt ]; then
  echo "/root/memory.txt is empty"
  exit 1
fi

if [ ! -f /root/disk.txt ]; then
  echo "/root/disk.txt does not exist"
  exit 1
fi

if [ ! -s /root/disk.txt ]; then
  echo "/root/disk.txt is empty"
  exit 1
fi

echo "Resource info captured. Good work!"
exit 0
