#!/bin/bash
for f in all-service-accounts.txt sa-permissions.txt legacy-tokens.txt sa-hardening.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < /root/sa-hardening.txt | tr -d ' ')
if [ "$LINES" -lt 4 ]; then
  echo "FAIL: Expected at least 4 best practices"
  exit 1
fi
echo "PASS"
exit 0
