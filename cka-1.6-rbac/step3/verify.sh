#!/bin/bash
if [ ! -f /root/can-i-result.txt ]; then
  echo "FAIL: /root/can-i-result.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/can-i-result.txt | tr -d '[:space:]')
if [ "$CONTENT" = "yes" ] || [ "$CONTENT" = "no" ]; then
  echo "PASS: File contains '$CONTENT'"
  exit 0
else
  echo "FAIL: File should contain 'yes' or 'no', got: $CONTENT"
  exit 1
fi
