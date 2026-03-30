#!/bin/bash
if kubectl get clusterrolebinding dashboard-admin-binding &>/dev/null; then
  echo "FAIL: dashboard-admin-binding should be deleted"
  exit 1
fi
for f in dashboard-bindings.txt rbac-comparison.txt final-bindings.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
