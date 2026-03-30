#!/bin/bash
kubectl get serviceaccount app-sa -n sa-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: ServiceAccount app-sa not found"
  exit 1
fi
if [ ! -f /root/sa-name.txt ]; then
  echo "FAIL: /root/sa-name.txt not found"
  exit 1
fi
echo "PASS"
exit 0
