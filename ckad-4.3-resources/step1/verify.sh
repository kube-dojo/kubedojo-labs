#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod resource-pod -n resources-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
CPU_REQ=$(kubectl get pod resource-pod -n resources-lab -o jsonpath='{.spec.containers[0].resources.requests.cpu}' 2>/dev/null)
if [ "$CPU_REQ" != "100m" ]; then
  echo "FAIL: CPU request should be 100m, got: $CPU_REQ"
  exit 1
fi
CPU_LIM=$(kubectl get pod resource-pod -n resources-lab -o jsonpath='{.spec.containers[0].resources.limits.cpu}' 2>/dev/null)
if [ "$CPU_LIM" != "200m" ]; then
  echo "FAIL: CPU limit should be 200m, got: $CPU_LIM"
  exit 1
fi
MEM_LIM=$(kubectl get pod resource-pod -n resources-lab -o jsonpath='{.spec.containers[0].resources.limits.memory}' 2>/dev/null)
if [ "$MEM_LIM" != "128Mi" ]; then
  echo "FAIL: Memory limit should be 128Mi"
  exit 1
fi
if [ ! -f /root/cpu-limit.txt ]; then
  echo "FAIL: /root/cpu-limit.txt not found"
  exit 1
fi
echo "PASS"
exit 0
