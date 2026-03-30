#!/bin/bash
POLICY="/etc/kubernetes/audit/audit-policy.yaml"
if [ ! -f "$POLICY" ]; then
  echo "FAIL: $POLICY not found"
  exit 1
fi
if ! grep -q "audit.k8s.io/v1" "$POLICY"; then
  echo "FAIL: Invalid apiVersion in audit policy"
  exit 1
fi
if ! grep -q "kind: Policy" "$POLICY"; then
  echo "FAIL: Missing kind: Policy"
  exit 1
fi
if ! grep -q "Metadata" "$POLICY"; then
  echo "FAIL: Missing Metadata level rule"
  exit 1
fi
if [ ! -f /root/audit-rule-count.txt ] || [ ! -s /root/audit-rule-count.txt ]; then
  echo "FAIL: /root/audit-rule-count.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
