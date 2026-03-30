#!/bin/bash
kubectl get networkpolicy api-egress -n netpol-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: NetworkPolicy api-egress not found"
  exit 1
fi
TARGET=$(kubectl get networkpolicy api-egress -n netpol-lab -o jsonpath='{.spec.podSelector.matchLabels.app}' 2>/dev/null)
if [ "$TARGET" != "api" ]; then
  echo "FAIL: Policy should target app=api"
  exit 1
fi
TYPES=$(kubectl get networkpolicy api-egress -n netpol-lab -o jsonpath='{.spec.policyTypes}' 2>/dev/null)
if [[ "$TYPES" != *"Egress"* ]]; then
  echo "FAIL: policyTypes should include Egress"
  exit 1
fi
if [ ! -f /root/api-egress.yaml ]; then
  echo "FAIL: /root/api-egress.yaml not found"
  exit 1
fi
echo "PASS"
exit 0
