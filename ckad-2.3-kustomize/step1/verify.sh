#!/bin/bash
if [ ! -f /root/kustomize/base/kustomization.yaml ]; then
  echo "FAIL: /root/kustomize/base/kustomization.yaml not found"
  exit 1
fi
if [ ! -f /root/kustomize/base/deployment.yaml ]; then
  echo "FAIL: deployment.yaml not found in base"
  exit 1
fi
if [ ! -f /root/base-output.yaml ]; then
  echo "FAIL: /root/base-output.yaml not found"
  exit 1
fi
if ! grep -q "kind: Deployment" /root/base-output.yaml; then
  echo "FAIL: base-output.yaml should contain Deployment"
  exit 1
fi
echo "PASS"
exit 0
