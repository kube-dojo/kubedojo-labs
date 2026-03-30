#!/bin/bash
if [ ! -f /root/api-versions.txt ]; then
  echo "FAIL: /root/api-versions.txt not found"
  exit 1
fi
if ! grep -q "apps/v1" /root/api-versions.txt; then
  echo "FAIL: api-versions.txt should contain apps/v1"
  exit 1
fi
if [ ! -f /root/api-resources.txt ]; then
  echo "FAIL: /root/api-resources.txt not found"
  exit 1
fi
if [ ! -f /root/deployment-api.txt ]; then
  echo "FAIL: /root/deployment-api.txt not found"
  exit 1
fi
echo "PASS"
exit 0
