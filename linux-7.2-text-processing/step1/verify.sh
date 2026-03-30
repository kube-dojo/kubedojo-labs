#!/bin/bash
if [ ! -f /root/awk-sum.txt ]; then
  echo "FAIL: /root/awk-sum.txt not found"
  exit 1
fi

VALUE=$(cat /root/awk-sum.txt | tr -d '[:space:]')
if [[ "$VALUE" =~ ^[0-9]+$ ]] && [ "$VALUE" -gt 0 ]; then
  echo "PASS: awk-sum.txt contains a number: $VALUE"
  exit 0
else
  echo "FAIL: Expected a positive number, got '$VALUE'"
  exit 1
fi
