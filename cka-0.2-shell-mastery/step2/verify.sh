#!/bin/bash
if [ ! -f /root/names.txt ]; then
  echo "FAIL: /root/names.txt does not exist"
  exit 1
fi

LINES=$(wc -l < /root/names.txt | tr -d ' ')
if [ "$LINES" -ge 1 ] && grep -q "alice" /root/names.txt; then
  echo "PASS: names.txt has content including expected names"
  exit 0
else
  echo "FAIL: names.txt should contain extracted names (alice, bob, etc.)"
  exit 1
fi
