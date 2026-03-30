#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if ! grep -q "profiling=false" "$MANIFEST"; then
  echo "FAIL: --profiling=false not set"
  exit 1
fi
if ! grep -q "audit-log-path" "$MANIFEST"; then
  echo "FAIL: --audit-log-path not configured"
  exit 1
fi
if ! grep -q "audit-log-maxage" "$MANIFEST"; then
  echo "FAIL: --audit-log-maxage not configured"
  exit 1
fi
# Wait for API server to be ready
for i in $(seq 1 30); do
  if kubectl get nodes &>/dev/null; then
    echo "PASS"
    exit 0
  fi
  sleep 2
done
echo "FAIL: API server did not recover"
exit 1
