#!/bin/bash
if [ ! -f /root/word-freq.txt ]; then
  echo "FAIL: /root/word-freq.txt not found"
  exit 1
fi

LINES=$(wc -l < /root/word-freq.txt)
if [ "$LINES" -eq 10 ]; then
  echo "PASS: word-freq.txt has 10 lines"
  exit 0
else
  echo "FAIL: Expected 10 lines, got $LINES"
  exit 1
fi
