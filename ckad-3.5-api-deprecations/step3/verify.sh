#!/bin/bash
if [ ! -f /root/migrated-manifest.yaml ]; then
  echo "FAIL: /root/migrated-manifest.yaml not found"
  exit 1
fi
if ! grep -q "apps/v1" /root/migrated-manifest.yaml; then
  echo "FAIL: migrated-manifest.yaml should use apps/v1"
  exit 1
fi
if [ ! -f /root/final-api-version.txt ]; then
  echo "FAIL: /root/final-api-version.txt not found"
  exit 1
fi
VER=$(cat /root/final-api-version.txt | tr -d '[:space:]')
if [ "$VER" != "apps/v1" ]; then
  echo "FAIL: final-api-version.txt should contain apps/v1"
  exit 1
fi
echo "PASS"
exit 0
