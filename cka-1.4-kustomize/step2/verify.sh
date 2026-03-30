#!/bin/bash
OUTPUT=$(kubectl kustomize /root/overlays/prod/ 2>&1)
if echo "$OUTPUT" | grep -q "prod-"; then
  echo "PASS: Overlay output contains 'prod-' prefix"
  exit 0
else
  echo "FAIL: Overlay output should contain 'prod-' prefix"
  exit 1
fi
