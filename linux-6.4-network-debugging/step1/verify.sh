#!/bin/bash
if [ ! -f /root/connectivity.txt ]; then
  echo "FAIL: /root/connectivity.txt not found"
  exit 1
fi

if [ -s /root/connectivity.txt ]; then
  echo "PASS: connectivity.txt exists and has content"
  exit 0
else
  echo "FAIL: connectivity.txt is empty"
  exit 1
fi
