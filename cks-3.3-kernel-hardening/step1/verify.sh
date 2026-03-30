#!/bin/bash
if ! kubectl get pod sysctl-pod -n kernel-lab &>/dev/null; then
  echo "FAIL: Pod sysctl-pod not found"
  exit 1
fi
for f in safe-sysctls.txt unsafe-sysctls.txt node-sysctls.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
