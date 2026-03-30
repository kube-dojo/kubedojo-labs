#!/bin/bash
if [ ! -f /root/image-policy.yaml ] || [ ! -s /root/image-policy.yaml ]; then
  echo "FAIL: /root/image-policy.yaml missing or empty"
  exit 1
fi
if [ ! -x /root/check-images.sh ]; then
  echo "FAIL: /root/check-images.sh not found or not executable"
  exit 1
fi
if [ ! -f /root/image-compliance.txt ] || [ ! -s /root/image-compliance.txt ]; then
  echo "FAIL: /root/image-compliance.txt missing or empty"
  exit 1
fi
if [ ! -f /root/approved-registries.txt ] || [ ! -s /root/approved-registries.txt ]; then
  echo "FAIL: /root/approved-registries.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
