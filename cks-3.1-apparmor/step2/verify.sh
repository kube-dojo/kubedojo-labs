#!/bin/bash
if ! kubectl get pod apparmor-pod -n apparmor-lab &>/dev/null; then
  echo "FAIL: Pod apparmor-pod not found"
  exit 1
fi
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod apparmor-pod -n apparmor-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: Pod not in Running state (got $STATUS)"
  exit 1
fi
for f in write-test.txt pod-apparmor.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
