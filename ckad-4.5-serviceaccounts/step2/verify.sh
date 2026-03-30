#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod sa-pod -n sa-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
SA=$(kubectl get pod sa-pod -n sa-lab -o jsonpath='{.spec.serviceAccountName}' 2>/dev/null)
if [ "$SA" != "app-sa" ]; then
  echo "FAIL: Pod should use app-sa ServiceAccount, got: $SA"
  exit 1
fi
if [ ! -f /root/pod-sa.txt ]; then
  echo "FAIL: /root/pod-sa.txt not found"
  exit 1
fi
echo "PASS"
exit 0
