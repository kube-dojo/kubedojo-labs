#!/bin/bash
if [ ! -f /root/error-count.txt ]; then
  echo "FAIL: /root/error-count.txt not found"
  exit 1
fi

COUNT=$(cat /root/error-count.txt | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]] && [ "$COUNT" -gt 0 ]; then
  echo "PASS: Found $COUNT error entries"
  exit 0
else
  echo "FAIL: error-count.txt should contain a positive number"
  exit 1
fi
