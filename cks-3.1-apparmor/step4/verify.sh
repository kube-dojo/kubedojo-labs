#!/bin/bash
for f in apparmor-denials.txt troubleshooting-guide.txt complain-mode.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
