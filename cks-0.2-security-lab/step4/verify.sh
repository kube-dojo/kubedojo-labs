#!/bin/bash
for f in admin-roles.txt service-accounts.txt psa-status.txt security-baseline.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
if ! grep -qiE "enabled|disabled" /root/psa-status.txt; then
  echo "FAIL: psa-status.txt should say enabled or disabled"
  exit 1
fi
echo "PASS"
exit 0
