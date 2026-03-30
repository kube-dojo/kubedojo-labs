#!/bin/bash
if [ ! -f /root/cache-test.txt ]; then
  echo "FAIL: /root/cache-test.txt not found"
  exit 1
fi

if [ -s /root/cache-test.txt ]; then
  echo "PASS: cache-test.txt exists and has content"
  exit 0
else
  echo "FAIL: cache-test.txt is empty"
  exit 1
fi
