#!/bin/bash
for f in rate-limits.txt rate-limit-docs.txt event-rate-limit.txt api-hardening-summary.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < /root/api-hardening-summary.txt | tr -d ' ')
if [ "$LINES" -lt 6 ]; then
  echo "FAIL: Expected at least 6 hardening items"
  exit 1
fi
echo "PASS"
exit 0
