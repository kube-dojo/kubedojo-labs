#!/bin/bash
if [ ! -f /root/code.txt ]; then
  echo "FAIL: /root/code.txt not found. Did you find the secret code in welcome.txt?"
  exit 1
fi
if grep -q "DOJO123" /root/code.txt; then
  echo "PASS: Secret code verified!"
  exit 0
else
  echo "FAIL: Incorrect code in /root/code.txt."
  exit 1
fi
