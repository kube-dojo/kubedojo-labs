#!/bin/bash
if [ ! -f /root/storage-classes.txt ]; then
  echo "FAIL: /root/storage-classes.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/storage-classes.txt | tr -d '[:space:]')
if [ -n "$CONTENT" ]; then
  echo "PASS: File has content"
  exit 0
else
  echo "FAIL: File is empty"
  exit 1
fi
