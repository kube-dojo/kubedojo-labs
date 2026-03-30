#!/bin/bash
# Verify enforce count file

if [ ! -f /root/enforce-count.txt ]; then
  echo "FAIL: /root/enforce-count.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/enforce-count.txt | tr -d '[:space:]')

if [[ "$CONTENT" =~ ^[0-9]+$ ]]; then
  echo "PASS: Enforce count is $CONTENT"
  exit 0
else
  echo "FAIL: /root/enforce-count.txt does not contain a number (found: '$CONTENT')"
  exit 1
fi
