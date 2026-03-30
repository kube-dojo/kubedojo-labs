#!/bin/bash
if [ ! -f /root/maintenance.txt ]; then
  echo "FAIL: /root/maintenance.txt not found"
  exit 1
fi

if [ -s /root/maintenance.txt ]; then
  echo "PASS: maintenance.txt has content"
  exit 0
else
  echo "FAIL: maintenance.txt is empty"
  exit 1
fi
