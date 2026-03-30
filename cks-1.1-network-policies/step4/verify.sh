#!/bin/bash
if ! kubectl get networkpolicy db-policy -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy db-policy not found"
  exit 1
fi
if [ ! -f /root/netpol-summary.txt ] || [ ! -s /root/netpol-summary.txt ]; then
  echo "FAIL: /root/netpol-summary.txt missing or empty"
  exit 1
fi
if [ ! -f /root/traffic-matrix.txt ] || [ ! -s /root/traffic-matrix.txt ]; then
  echo "FAIL: /root/traffic-matrix.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
