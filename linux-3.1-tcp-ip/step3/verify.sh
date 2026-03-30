#!/bin/bash
# Verify that /root/tcp-connections.txt exists and has content
if [ ! -f /root/tcp-connections.txt ]; then
  echo "FAIL: /root/tcp-connections.txt does not exist"
  exit 1
fi

if [ -s /root/tcp-connections.txt ]; then
  echo "PASS: File has content"
  exit 0
else
  echo "FAIL: /root/tcp-connections.txt is empty"
  exit 1
fi
