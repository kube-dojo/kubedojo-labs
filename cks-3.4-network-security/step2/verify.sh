#!/bin/bash
if ! kubectl get pod isolated-pod -n host-lab &>/dev/null; then
  echo "FAIL: Pod isolated-pod not found"
  exit 1
fi
if ! kubectl get pod hostnet-pod -n host-lab &>/dev/null; then
  echo "FAIL: Pod hostnet-pod not found"
  exit 1
fi
HOSTNET=$(kubectl get pod hostnet-pod -n host-lab -o jsonpath='{.spec.hostNetwork}')
if [ "$HOSTNET" != "true" ]; then
  echo "FAIL: hostnet-pod should have hostNetwork=true"
  exit 1
fi
for f in host-namespace-risks.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
