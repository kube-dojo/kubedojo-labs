#!/bin/bash
if ! kubectl get pod projected-token-pod -n sa-lab &>/dev/null; then
  echo "FAIL: Pod projected-token-pod not found"
  exit 1
fi
VOL=$(kubectl get pod projected-token-pod -n sa-lab -o jsonpath='{.spec.volumes[*].projected}')
if [ -z "$VOL" ]; then
  echo "FAIL: Pod should have a projected volume"
  exit 1
fi
for f in projected-token.txt token-comparison.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
