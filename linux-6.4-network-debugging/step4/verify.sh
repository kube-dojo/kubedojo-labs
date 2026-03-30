#!/bin/bash
if [ ! -f /root/tcpdump-output.txt ]; then
  echo "FAIL: /root/tcpdump-output.txt not found"
  exit 1
fi

if [ -s /root/tcpdump-output.txt ]; then
  echo "PASS: tcpdump-output.txt has content"
  exit 0
else
  echo "FAIL: tcpdump-output.txt is empty"
  exit 1
fi
