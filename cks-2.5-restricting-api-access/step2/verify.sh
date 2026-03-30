#!/bin/bash
if ! kubectl get sa limited-user &>/dev/null; then
  echo "FAIL: ServiceAccount limited-user not found"
  exit 1
fi
for f in anon-access.txt auth-access.txt sa-access.txt access-comparison.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
