#!/bin/bash
if ! kubectl get clusterrole dashboard-viewer &>/dev/null; then
  echo "FAIL: ClusterRole dashboard-viewer not found"
  exit 1
fi
if ! kubectl get clusterrolebinding dashboard-readonly-binding &>/dev/null; then
  echo "FAIL: ClusterRoleBinding dashboard-readonly-binding not found"
  exit 1
fi
RESULT=$(kubectl auth can-i get secrets -n default --as=system:serviceaccount:kubernetes-dashboard:dashboard-readonly 2>&1)
if [ "$RESULT" == "yes" ]; then
  echo "FAIL: dashboard-readonly should NOT be able to get secrets"
  exit 1
fi
if [ ! -f /root/readonly-secrets-check.txt ]; then
  echo "FAIL: /root/readonly-secrets-check.txt not found"
  exit 1
fi
echo "PASS"
exit 0
