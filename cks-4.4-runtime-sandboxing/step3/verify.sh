#!/bin/bash
if ! kubectl get pod standard-pod -n sandbox-lab &>/dev/null; then
  echo "FAIL: Pod standard-pod not found"
  exit 1
fi
for f in standard-kernel.txt isolation-matrix.txt sandbox-decision.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
