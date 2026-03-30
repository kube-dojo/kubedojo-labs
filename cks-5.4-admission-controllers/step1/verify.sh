#!/bin/bash
for f in enabled-plugins.txt security-plugins.txt always-pull-status.txt admission-flow.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
