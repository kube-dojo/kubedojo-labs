#!/bin/bash
# Verify /root/cpu-model.txt has content
if [ ! -f /root/cpu-model.txt ]; then
  echo "/root/cpu-model.txt does not exist"
  exit 1
fi

if [ ! -s /root/cpu-model.txt ]; then
  echo "/root/cpu-model.txt is empty"
  exit 1
fi

echo "CPU model: $(cat /root/cpu-model.txt)"
exit 0
