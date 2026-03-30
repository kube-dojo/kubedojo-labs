#!/bin/bash
# Verify both files exist with content
if [ ! -f /root/kernel-version.txt ]; then
  echo "/root/kernel-version.txt does not exist"
  exit 1
fi

if [ ! -s /root/kernel-version.txt ]; then
  echo "/root/kernel-version.txt is empty"
  exit 1
fi

if [ ! -f /root/module-count.txt ]; then
  echo "/root/module-count.txt does not exist"
  exit 1
fi

count=$(cat /root/module-count.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Kernel: $(cat /root/kernel-version.txt | tr -d '[:space:]'), Modules: $count"
  exit 0
else
  echo "module-count.txt should contain a number, got: '$count'"
  exit 1
fi
