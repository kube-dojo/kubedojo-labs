#!/bin/bash
if [ ! -x /root/immutability-audit.sh ]; then
  echo "FAIL: /root/immutability-audit.sh not found or not executable"
  exit 1
fi
for f in immutability-report.txt immutability-best-practices.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < /root/immutability-best-practices.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: Expected at least 5 best practices"
  exit 1
fi
echo "PASS"
exit 0
