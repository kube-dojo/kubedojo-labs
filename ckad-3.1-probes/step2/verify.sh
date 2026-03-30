#!/bin/bash
for i in $(seq 1 30); do
  READY=$(kubectl get deployment ready-app -n probes-lab -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  [ "$READY" = "3" ] && break
  sleep 2
done
if [ "$READY" != "3" ]; then
  echo "FAIL: ready-app should have 3 ready replicas"
  exit 1
fi

PROBE=$(kubectl get deployment ready-app -n probes-lab -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.httpGet.path}' 2>/dev/null)
if [ "$PROBE" != "/" ]; then
  echo "FAIL: Readiness probe should check /"
  exit 1
fi

kubectl get svc ready-svc -n probes-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: Service ready-svc not found"
  exit 1
fi

if [ ! -f /root/ready-endpoints.txt ]; then
  echo "FAIL: /root/ready-endpoints.txt not found"
  exit 1
fi
echo "PASS"
exit 0
