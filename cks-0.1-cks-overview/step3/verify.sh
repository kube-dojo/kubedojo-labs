#!/bin/bash
if [ ! -f /root/insecure-pod.txt ]; then
  echo "FAIL: /root/insecure-pod.txt not found"
  exit 1
fi
if ! grep -q "insecure-pod" /root/insecure-pod.txt; then
  echo "FAIL: insecure-pod not correctly identified"
  exit 1
fi
if [ ! -f /root/secure-pod.txt ]; then
  echo "FAIL: /root/secure-pod.txt not found"
  exit 1
fi
if ! grep -q "safe-pod" /root/secure-pod.txt; then
  echo "FAIL: safe-pod not correctly identified"
  exit 1
fi
if [ ! -f /root/security-fixes.txt ]; then
  echo "FAIL: /root/security-fixes.txt not found"
  exit 1
fi
LINES=$(wc -l < /root/security-fixes.txt | tr -d ' ')
if [ "$LINES" -lt 3 ]; then
  echo "FAIL: Expected at least 3 security fixes"
  exit 1
fi
echo "PASS"
exit 0
