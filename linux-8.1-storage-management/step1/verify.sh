#!/bin/bash
if [ ! -f /root/block-devices.txt ]; then
  echo "FAIL: /root/block-devices.txt not found"
  exit 1
fi

if [ -s /root/block-devices.txt ]; then
  echo "PASS: block-devices.txt has content"
  exit 0
else
  echo "FAIL: block-devices.txt is empty"
  exit 1
fi
