#!/bin/bash
MISSING=0
for i in 1 2 3 4 5; do
  if [ ! -f "/root/timed/test-${i}.txt" ]; then
    echo "FAIL: /root/timed/test-${i}.txt does not exist"
    MISSING=1
  fi
done

if [ "$MISSING" -eq 0 ]; then
  echo "PASS: All 5 files exist in /root/timed/"
  exit 0
else
  exit 1
fi
