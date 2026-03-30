#!/bin/bash
if ! kubectl get sa no-api-access -n sa-lab &>/dev/null; then
  echo "FAIL: ServiceAccount no-api-access not found"
  exit 1
fi
AUTOMOUNT=$(kubectl get sa no-api-access -n sa-lab -o jsonpath='{.automountServiceAccountToken}')
if [ "$AUTOMOUNT" != "false" ]; then
  echo "FAIL: no-api-access should have automountServiceAccountToken=false"
  exit 1
fi
if ! kubectl get pod secure-app -n sa-lab &>/dev/null; then
  echo "FAIL: Pod secure-app not found"
  exit 1
fi
if ! kubectl get pod needs-api -n sa-lab &>/dev/null; then
  echo "FAIL: Pod needs-api not found"
  exit 1
fi
if [ ! -f /root/token-check.txt ]; then
  echo "FAIL: /root/token-check.txt not found"
  exit 1
fi
echo "PASS"
exit 0
