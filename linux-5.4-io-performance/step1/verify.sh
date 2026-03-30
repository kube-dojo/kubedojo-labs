#!/bin/bash
if [ ! -f /root/iostat.txt ]; then
  echo "FAIL: /root/iostat.txt not found"
  exit 1
fi

if [ -s /root/iostat.txt ]; then
  echo "PASS: iostat.txt has content"
  exit 0
else
  echo "FAIL: iostat.txt is empty"
  exit 1
fi
