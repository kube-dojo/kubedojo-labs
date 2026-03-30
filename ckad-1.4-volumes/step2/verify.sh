#!/bin/bash
for i in $(seq 1 30); do
  PVC_STATUS=$(kubectl get pvc pvc-data -n volumes-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$PVC_STATUS" = "Bound" ] && break
  sleep 2
done
if [ "$PVC_STATUS" != "Bound" ]; then
  echo "FAIL: PVC pvc-data should be Bound, got: $PVC_STATUS"
  exit 1
fi

PV_CAP=$(kubectl get pv pv-data -o jsonpath='{.spec.capacity.storage}' 2>/dev/null)
if [ "$PV_CAP" != "1Gi" ]; then
  echo "FAIL: PV capacity should be 1Gi"
  exit 1
fi

if [ ! -f /root/pvc-status.txt ]; then
  echo "FAIL: /root/pvc-status.txt not found"
  exit 1
fi
FILE_STATUS=$(cat /root/pvc-status.txt | tr -d '[:space:]')
if [ "$FILE_STATUS" != "Bound" ]; then
  echo "FAIL: pvc-status.txt should contain Bound"
  exit 1
fi

echo "PASS"
exit 0
