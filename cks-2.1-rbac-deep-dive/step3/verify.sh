#!/bin/bash
for f in cluster-admin-bindings.txt overprivileged-sa.txt secret-admin-audit.txt rbac-risks.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
RISKS=$(wc -l < /root/rbac-risks.txt | tr -d ' ')
if [ "$RISKS" -lt 3 ]; then
  echo "FAIL: Expected at least 3 RBAC risks"
  exit 1
fi
echo "PASS"
exit 0
