#!/bin/bash
for f in antipatterns.yaml antipatterns-list.txt antipatterns-fixed.yaml antipattern-scores.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < /root/antipatterns-list.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: Expected at least 5 anti-patterns identified"
  exit 1
fi
echo "PASS"
exit 0
