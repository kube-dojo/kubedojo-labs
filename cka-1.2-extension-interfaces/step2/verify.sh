#!/bin/bash
if [ ! -f /root/cni-plugin.txt ]; then
  echo "FAIL: /root/cni-plugin.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/cni-plugin.txt | tr -d '[:space:]')
if [ -n "$CONTENT" ]; then
  echo "PASS: File contains CNI plugin information: $CONTENT"
  exit 0
else
  echo "FAIL: File is empty"
  exit 1
fi
