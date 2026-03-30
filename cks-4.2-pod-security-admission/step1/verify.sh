#!/bin/bash
for ns in psa-privileged psa-baseline psa-restricted; do
  if ! kubectl get namespace $ns &>/dev/null; then
    echo "FAIL: Namespace $ns not found"
    exit 1
  fi
done
LABEL=$(kubectl get namespace psa-restricted -o jsonpath='{.metadata.labels.pod-security\.kubernetes\.io/enforce}')
if [ "$LABEL" != "restricted" ]; then
  echo "FAIL: psa-restricted should have enforce=restricted label"
  exit 1
fi
for f in psa-labels.txt psa-deployment-test.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
