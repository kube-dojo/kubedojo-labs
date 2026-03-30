#!/bin/bash
# Verify SELinux booleans file

if [ ! -f /root/sebooleans.txt ]; then
  echo "FAIL: /root/sebooleans.txt does not exist"
  exit 1
fi

if [ ! -s /root/sebooleans.txt ]; then
  echo "FAIL: /root/sebooleans.txt is empty"
  exit 1
fi

echo "PASS: SELinux booleans documented"
exit 0
