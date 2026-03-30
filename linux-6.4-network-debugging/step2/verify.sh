#!/bin/bash
if [ ! -f /root/dns-debug.txt ]; then
  echo "FAIL: /root/dns-debug.txt not found"
  exit 1
fi

if [ -s /root/dns-debug.txt ]; then
  echo "PASS: dns-debug.txt has content"
  exit 0
else
  echo "FAIL: dns-debug.txt is empty"
  exit 1
fi
