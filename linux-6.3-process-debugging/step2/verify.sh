#!/bin/bash
if [ ! -f /root/open-files.txt ]; then
  echo "FAIL: /root/open-files.txt not found"
  exit 1
fi

if [ -s /root/open-files.txt ]; then
  echo "PASS: open-files.txt has content"
  exit 0
else
  echo "FAIL: open-files.txt is empty"
  exit 1
fi
