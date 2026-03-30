#!/bin/bash
# Verify node-count.txt exists and contains a number >= 1
if [ ! -f /root/node-count.txt ]; then
  echo "FAIL: /root/node-count.txt does not exist"
  exit 1
fi

COUNT=$(cat /root/node-count.txt | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]] && [ "$COUNT" -ge 1 ]; then
  echo "PASS: Node count is $COUNT"
  exit 0
else
  echo "FAIL: /root/node-count.txt should contain a number >= 1, got: $COUNT"
  exit 1
fi
