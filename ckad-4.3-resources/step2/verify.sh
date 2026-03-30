#!/bin/bash
kubectl get limitrange default-limits -n resources-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: LimitRange default-limits not found"
  exit 1
fi
for i in $(seq 1 30); do
  S=$(kubectl get pod auto-limits -n resources-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
CPU=$(kubectl get pod auto-limits -n resources-lab -o jsonpath='{.spec.containers[0].resources.limits.cpu}' 2>/dev/null)
if [ "$CPU" != "500m" ]; then
  echo "FAIL: auto-limits should have default CPU limit 500m, got: $CPU"
  exit 1
fi
if [ ! -f /root/auto-cpu-limit.txt ]; then
  echo "FAIL: /root/auto-cpu-limit.txt not found"
  exit 1
fi
echo "PASS"
exit 0
