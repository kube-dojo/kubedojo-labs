#!/bin/bash
FILE="/root/upgrade-plan.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -q "COMPONENT" "$FILE" && grep -q "CURRENT" "$FILE"; then
  echo "PASS: Upgrade plan verified"
  exit 0
else
  echo "FAIL: File does not appear to be a valid 'kubeadm upgrade plan' output"
  exit 1
fi