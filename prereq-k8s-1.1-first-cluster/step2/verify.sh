#!/bin/bash
FILE="/root/cp-pod-count.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
COUNT=$(cat "$FILE" | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]] && [ "$COUNT" -gt 0 ]; then
  echo "PASS: Pod count verified!"
  exit 0
else
  echo "FAIL: Incorrect count in $FILE. Expected a number."
  exit 1
fi
