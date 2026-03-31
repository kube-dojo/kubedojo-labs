#!/bin/bash
# Wait for the pod to be ready (may still be pulling image)
kubectl wait --for=condition=Ready pod/standard-pod -n sandbox-lab --timeout=30s 2>/dev/null || true

if ! kubectl get pod standard-pod -n sandbox-lab &>/dev/null; then
  echo "FAIL: Pod standard-pod not found in namespace sandbox-lab"
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
