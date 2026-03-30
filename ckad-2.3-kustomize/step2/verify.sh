#!/bin/bash
if [ ! -f /root/kustomize/overlays/staging/kustomization.yaml ]; then
  echo "FAIL: staging kustomization not found"
  exit 1
fi
if [ ! -f /root/kustomize/overlays/production/kustomization.yaml ]; then
  echo "FAIL: production kustomization not found"
  exit 1
fi
if [ ! -f /root/staging-output.yaml ]; then
  echo "FAIL: staging-output.yaml not found"
  exit 1
fi
if ! grep -q "staging-" /root/staging-output.yaml; then
  echo "FAIL: staging output should have staging- prefix"
  exit 1
fi
if [ ! -f /root/production-output.yaml ]; then
  echo "FAIL: production-output.yaml not found"
  exit 1
fi
if ! grep -q "prod-" /root/production-output.yaml; then
  echo "FAIL: production output should have prod- prefix"
  exit 1
fi
echo "PASS"
exit 0
