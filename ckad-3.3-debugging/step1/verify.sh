#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod crasher -n debug-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: crasher should be Running after fix"
  exit 1
fi
if [ ! -f /root/crash-reason.txt ]; then
  echo "FAIL: /root/crash-reason.txt not found"
  exit 1
fi
echo "PASS"
exit 0
