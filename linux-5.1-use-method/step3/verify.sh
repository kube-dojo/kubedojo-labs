#!/bin/bash
# Verify use-checklist.txt has entries for all 4 resources
if [ ! -f /root/use-checklist.txt ]; then
  echo "FAIL: /root/use-checklist.txt not found"
  exit 1
fi

ERRORS=0
for resource in CPU Memory Disk Network; do
  if ! grep -qi "$resource" /root/use-checklist.txt; then
    echo "FAIL: Missing entry for $resource"
    ERRORS=$((ERRORS + 1))
  fi
done

for metric in Utilization Saturation Errors; do
  if ! grep -qi "$metric" /root/use-checklist.txt; then
    echo "FAIL: Missing metric $metric"
    ERRORS=$((ERRORS + 1))
  fi
done

if [ "$ERRORS" -eq 0 ]; then
  echo "PASS: USE checklist contains all 4 resources and 3 metrics"
  exit 0
else
  echo "FAIL: Missing $ERRORS entries"
  exit 1
fi
