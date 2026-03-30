#!/bin/bash
for f in auth-mode.txt auth-mode-check.txt current-user-perms.txt auth-mode-explanation.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
