#!/bin/bash
if [ ! -f /root/ltrace-output.txt ]; then
  echo "FAIL: /root/ltrace-output.txt not found"
  exit 1
fi

if [ -s /root/ltrace-output.txt ]; then
  echo "PASS: ltrace-output.txt has content"
  exit 0
else
  echo "FAIL: ltrace-output.txt is empty"
  exit 1
fi
