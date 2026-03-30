#!/bin/bash
# Verify that /root/isolation-test.txt exists and has content
if [ ! -f /root/isolation-test.txt ]; then
  echo "FAIL: /root/isolation-test.txt does not exist"
  exit 1
fi

if [ -s /root/isolation-test.txt ]; then
  echo "PASS: /root/isolation-test.txt exists and has content (isolation test performed)"
  exit 0
else
  echo "FAIL: /root/isolation-test.txt is empty"
  exit 1
fi
