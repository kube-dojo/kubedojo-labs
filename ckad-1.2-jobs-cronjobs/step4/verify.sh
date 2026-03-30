#!/bin/bash
# broken-job should be deleted
kubectl get job broken-job -n jobs-lab > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "FAIL: broken-job should be deleted"
  exit 1
fi

for i in $(seq 1 30); do
  SUCC=$(kubectl get job fixed-job -n jobs-lab -o jsonpath='{.status.succeeded}' 2>/dev/null)
  [ "$SUCC" = "1" ] && break
  sleep 2
done
if [ "$SUCC" != "1" ]; then
  echo "FAIL: fixed-job should have succeeded"
  exit 1
fi

echo "PASS"
exit 0
