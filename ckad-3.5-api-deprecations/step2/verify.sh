#!/bin/bash
kubectl get deployment legacy-app -n api-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: legacy-app deployment not found"
  exit 1
fi
if [ ! -f /root/explain-output.txt ]; then
  echo "FAIL: /root/explain-output.txt not found"
  exit 1
fi
echo "PASS"
exit 0
