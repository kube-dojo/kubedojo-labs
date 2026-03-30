#!/bin/bash
if ! command -v trivy &>/dev/null; then
  echo "FAIL: trivy not installed"
  exit 1
fi
if [ ! -f /root/trivy-version.txt ] || [ ! -s /root/trivy-version.txt ]; then
  echo "FAIL: /root/trivy-version.txt missing or empty"
  exit 1
fi
if [ ! -f /root/kubesec-version.txt ] || [ ! -s /root/kubesec-version.txt ]; then
  echo "FAIL: /root/kubesec-version.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
