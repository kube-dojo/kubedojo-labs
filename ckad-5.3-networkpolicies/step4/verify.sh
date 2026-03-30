#!/bin/bash
kubectl get networkpolicy db-policy -n netpol-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: NetworkPolicy db-policy not found"
  exit 1
fi
TARGET=$(kubectl get networkpolicy db-policy -n netpol-lab -o jsonpath='{.spec.podSelector.matchLabels.app}' 2>/dev/null)
if [ "$TARGET" != "db" ]; then
  echo "FAIL: Policy should target app=db"
  exit 1
fi
TYPES=$(kubectl get networkpolicy db-policy -n netpol-lab -o jsonpath='{.spec.policyTypes}' 2>/dev/null)
if [[ "$TYPES" != *"Ingress"* ]] || [[ "$TYPES" != *"Egress"* ]]; then
  echo "FAIL: policyTypes should include both Ingress and Egress"
  exit 1
fi
FROM=$(kubectl get networkpolicy db-policy -n netpol-lab -o jsonpath='{.spec.ingress[0].from[0].podSelector.matchLabels.app}' 2>/dev/null)
if [ "$FROM" != "api" ]; then
  echo "FAIL: Ingress should allow from app=api"
  exit 1
fi
if [ ! -f /root/total-policies.txt ]; then
  echo "FAIL: /root/total-policies.txt not found"
  exit 1
fi
echo "PASS"
exit 0
