#!/bin/bash
OUTPUT=$(kubectl kustomize /root/overlays/prod/ 2>/dev/null)
if echo "$OUTPUT" | grep -q "name: prod-myapp" && echo "$OUTPUT" | grep -q "replicas: 3"; then
  echo "PASS: Overlay output verified with prefix and patch"
  exit 0
else
  echo "FAIL: Overlay output missing 'prod-' prefix or 'replicas: 3' patch"
  exit 1
fi