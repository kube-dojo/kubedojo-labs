#!/bin/bash
if [ ! -f /root/mem-stats.txt ]; then
  echo "FAIL: /root/mem-stats.txt not found"
  exit 1
fi

COUNT=$(grep -cE '[0-9]+' /root/mem-stats.txt)
if [ "$COUNT" -ge 3 ]; then
  echo "PASS: mem-stats.txt has at least 3 values"
  exit 0
else
  echo "FAIL: Expected at least 3 numeric values, found $COUNT"
  exit 1
fi
