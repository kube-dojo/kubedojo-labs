#!/bin/bash
FILE="/root/deploy-short.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(cat "$FILE" | tr -d '[:space:]')
if [ "$CONTENT" = "deploy" ]; then
  echo "PASS: deploy-short.txt contains the correct short name"
  exit 0
else
  echo "FAIL: expected 'deploy', got: '$CONTENT'"
  exit 1
fi