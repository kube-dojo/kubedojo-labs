#!/bin/bash
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod pvc-pod -n volumes-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: pvc-pod not Running"
  exit 1
fi

CONTENT=$(kubectl exec pvc-pod -n volumes-lab -- cat /data/output.txt 2>/dev/null)
if [[ "$CONTENT" != *"persistent-data"* ]]; then
  echo "FAIL: /data/output.txt should contain persistent-data"
  exit 1
fi

if [ ! -f /root/persistent-output.txt ]; then
  echo "FAIL: /root/persistent-output.txt not found"
  exit 1
fi

echo "PASS"
exit 0
