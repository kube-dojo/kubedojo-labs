#!/bin/bash
if ! kubectl get networkpolicy deny-all-ingress -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy deny-all-ingress not found in backend"
  exit 1
fi
if ! kubectl get networkpolicy deny-all-egress -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy deny-all-egress not found in backend"
  exit 1
fi
TYPES=$(kubectl get networkpolicy deny-all-ingress -n backend -o jsonpath='{.spec.policyTypes[*]}')
if [[ "$TYPES" != *"Ingress"* ]]; then
  echo "FAIL: deny-all-ingress must have Ingress policyType"
  exit 1
fi
if [ ! -f /root/netpol-test-1.txt ]; then
  echo "FAIL: /root/netpol-test-1.txt not found"
  exit 1
fi
echo "PASS"
exit 0
