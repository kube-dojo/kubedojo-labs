#!/bin/bash
if [ ! -x /root/cluster-scan.sh ]; then
  echo "FAIL: /root/cluster-scan.sh not found or not executable"
  exit 1
fi
for f in cluster-scan-results.txt scanning-best-practices.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
