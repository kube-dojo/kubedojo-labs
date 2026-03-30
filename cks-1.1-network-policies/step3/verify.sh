#!/bin/bash
if ! kubectl get networkpolicy api-egress-restrict -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy api-egress-restrict not found"
  exit 1
fi
TYPES=$(kubectl get networkpolicy api-egress-restrict -n backend -o jsonpath='{.spec.policyTypes[*]}')
if [[ "$TYPES" != *"Egress"* ]]; then
  echo "FAIL: Policy must include Egress policyType"
  exit 1
fi
if [ ! -f /root/dns-ip.txt ] || [ ! -s /root/dns-ip.txt ]; then
  echo "FAIL: /root/dns-ip.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
