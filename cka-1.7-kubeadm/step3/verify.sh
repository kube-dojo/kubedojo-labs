#!/bin/bash
if [ ! -f /root/upgrade-plan.txt ]; then
  echo "FAIL: /root/upgrade-plan.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/upgrade-plan.txt | tr -d '[:space:]')
if [ -n "$CONTENT" ]; then
  echo "PASS: File has content"
  exit 0
else
  echo "FAIL: File is empty"
  exit 1
fi
