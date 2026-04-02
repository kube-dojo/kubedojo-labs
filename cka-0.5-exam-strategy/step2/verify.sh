#!/bin/bash
FILE="/root/task-order.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(tr -d '[:space:]' < "$FILE" | tr '[:lower:]' '[:upper:]')

if [ "$CONTENT" = "BDEAC" ]; then
  echo "PASS: Optimal task order verified!"
  exit 0
else
  echo "FAIL: Incorrect order. Found: $CONTENT, Expected: BDEAC"
  exit 1
fi