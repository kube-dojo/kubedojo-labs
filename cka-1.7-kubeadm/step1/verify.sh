#!/bin/bash
if [ ! -f /root/cluster-name.txt ]; then
  echo "FAIL: /root/cluster-name.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/cluster-name.txt | tr -d '[:space:]')
if [ -n "$CONTENT" ]; then
  echo "PASS: File contains cluster name: $CONTENT"
  exit 0
else
  echo "FAIL: File is empty"
  exit 1
fi
