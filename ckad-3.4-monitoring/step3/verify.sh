#!/bin/bash
kubectl get pod stress-pod -n monitoring-lab > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "FAIL: stress-pod should be deleted"
  exit 1
fi
if [ ! -f /root/high-cpu-pod.txt ]; then
  echo "FAIL: /root/high-cpu-pod.txt not found"
  exit 1
fi
CONTENT=$(cat /root/high-cpu-pod.txt | tr -d '[:space:]')
if [ "$CONTENT" != "stress-pod" ]; then
  echo "FAIL: high-cpu-pod.txt should contain stress-pod"
  exit 1
fi
if [ ! -f /root/remaining-pods.txt ]; then
  echo "FAIL: /root/remaining-pods.txt not found"
  exit 1
fi
echo "PASS"
exit 0
