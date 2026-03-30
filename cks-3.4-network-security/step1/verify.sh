#!/bin/bash
for f in listening-ports.txt running-services.txt port-analysis.txt k8s-ports.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
if ! grep -q "6443" /root/k8s-ports.txt; then
  echo "FAIL: k8s-ports.txt should include 6443"
  exit 1
fi
echo "PASS"
exit 0
