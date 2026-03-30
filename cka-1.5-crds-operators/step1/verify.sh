#!/bin/bash
if [ ! -f /root/crd-count.txt ]; then
  echo "FAIL: /root/crd-count.txt does not exist"
  exit 1
fi

COUNT=$(cat /root/crd-count.txt | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]]; then
  echo "PASS: File contains a number: $COUNT"
  exit 0
else
  echo "FAIL: File should contain a number, got: $COUNT"
  exit 1
fi
