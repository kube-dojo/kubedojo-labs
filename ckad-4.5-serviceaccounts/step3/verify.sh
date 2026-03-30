#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod no-token-pod -n sa-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
AM=$(kubectl get pod no-token-pod -n sa-lab -o jsonpath='{.spec.automountServiceAccountToken}' 2>/dev/null)
if [ "$AM" != "false" ]; then
  echo "FAIL: automountServiceAccountToken should be false"
  exit 1
fi
if [ ! -f /root/automount-value.txt ]; then
  echo "FAIL: /root/automount-value.txt not found"
  exit 1
fi
echo "PASS"
exit 0
