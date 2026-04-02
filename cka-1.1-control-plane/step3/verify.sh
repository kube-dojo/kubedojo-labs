#!/bin/bash
FILE="/root/service-cidr.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -qE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+" "$FILE"; then
  echo "PASS: Service CIDR range found"
  exit 0
else
  echo "FAIL: File should contain a valid CIDR range (e.g., 10.96.0.0/12)"
  exit 1
fi