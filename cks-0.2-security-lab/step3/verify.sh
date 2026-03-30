#!/bin/bash
if ! kubectl get deployment vuln-app -n security-lab &>/dev/null; then
  echo "FAIL: vuln-app deployment not found"
  exit 1
fi
if ! kubectl get deployment hardened-app -n security-lab &>/dev/null; then
  echo "FAIL: hardened-app deployment not found"
  exit 1
fi
PRIV=$(kubectl get deployment vuln-app -n security-lab -o jsonpath='{.spec.template.spec.containers[0].securityContext.privileged}')
if [ "$PRIV" != "true" ]; then
  echo "FAIL: vuln-app should be privileged"
  exit 1
fi
NONROOT=$(kubectl get deployment hardened-app -n security-lab -o jsonpath='{.spec.template.spec.containers[0].securityContext.runAsNonRoot}')
if [ "$NONROOT" != "true" ]; then
  echo "FAIL: hardened-app should have runAsNonRoot=true"
  exit 1
fi
echo "PASS"
exit 0
