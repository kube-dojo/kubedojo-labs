#!/bin/bash
for f in scan-nginx-old.txt scan-nginx-new.txt scan-critical.txt scan-report.json; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
