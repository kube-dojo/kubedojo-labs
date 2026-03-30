#!/bin/bash
if [ ! -f /root/deploy-short.txt ]; then
  echo "FAIL: /root/deploy-short.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/deploy-short.txt | tr -d '[:space:]')
if echo "$CONTENT" | grep -q "deploy"; then
  echo "PASS: File contains 'deploy'"
  exit 0
else
  echo "FAIL: File should contain 'deploy', got: $CONTENT"
  exit 1
fi
