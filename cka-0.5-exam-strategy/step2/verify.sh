#!/bin/bash
if [ ! -f /root/task-order.txt ]; then
  echo "FAIL: /root/task-order.txt does not exist"
  exit 1
fi

LINES=$(wc -l < /root/task-order.txt | tr -d ' ')
if [ "$LINES" -ge 5 ]; then
  echo "PASS: task-order.txt has $LINES lines (need >= 5)"
  exit 0
else
  echo "FAIL: task-order.txt should have 5 lines (one per task), found $LINES"
  exit 1
fi
