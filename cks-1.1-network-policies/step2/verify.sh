#!/bin/bash
if ! kubectl get networkpolicy allow-frontend-to-api -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy allow-frontend-to-api not found"
  exit 1
fi
SELECTOR=$(kubectl get networkpolicy allow-frontend-to-api -n backend -o jsonpath='{.spec.podSelector.matchLabels.app}')
if [ "$SELECTOR" != "api" ]; then
  echo "FAIL: Policy should select app=api pods"
  exit 1
fi
if [ ! -f /root/netpol-test-2.txt ] || [ ! -s /root/netpol-test-2.txt ]; then
  echo "FAIL: /root/netpol-test-2.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
