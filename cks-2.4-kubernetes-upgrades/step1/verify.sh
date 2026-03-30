#!/bin/bash
for f in current-version.txt upgrade-plan.txt upgrade-checklist.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < /root/upgrade-checklist.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: Expected at least 5 checklist items"
  exit 1
fi
echo "PASS"
exit 0
