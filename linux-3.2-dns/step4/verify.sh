#!/bin/bash
# Verify that /root/k8s-io-ip.txt exists and contains an IP
if [ ! -f /root/k8s-io-ip.txt ]; then
  echo "FAIL: /root/k8s-io-ip.txt does not exist"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' /root/k8s-io-ip.txt; then
  echo "PASS: File contains an IP address for kubernetes.io"
  exit 0
else
  echo "FAIL: /root/k8s-io-ip.txt does not contain an IP address"
  exit 1
fi
