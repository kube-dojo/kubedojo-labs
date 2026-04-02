#!/bin/bash
FILE="/root/cluster-name.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(cat "$FILE" | tr -d '[:space:]')
EXPECTED=$(kubectl config view -o jsonpath='{.clusters[0].name}')

if [ "$CONTENT" = "$EXPECTED" ]; then
  echo "PASS: Correct cluster name identified: $CONTENT"
  exit 0
else
  echo "FAIL: Expected '$EXPECTED', got: '$CONTENT'"
  exit 1
fi