#!/bin/bash
FILE="/root/web-pod-ip.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
IP=$(cat "$FILE" | tr -d '[:space:]')
if [[ "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "PASS: Pod IP verified!"
  exit 0
else
  echo "FAIL: $FILE does not contain a valid IP address. Found: $IP"
  exit 1
fi
