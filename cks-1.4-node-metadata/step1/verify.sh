#!/bin/bash
for f in metadata-endpoints.txt metadata-test-before.txt pod-node.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
if ! grep -q "169.254.169.254" /root/metadata-endpoints.txt; then
  echo "FAIL: metadata-endpoints.txt should contain 169.254.169.254"
  exit 1
fi
echo "PASS"
exit 0
