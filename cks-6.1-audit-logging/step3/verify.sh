#!/bin/bash
if [ ! -x /root/audit-analyzer.sh ]; then
  echo "FAIL: /root/audit-analyzer.sh not found or not executable"
  exit 1
fi
for f in audit-analysis.txt suspicious-patterns.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
