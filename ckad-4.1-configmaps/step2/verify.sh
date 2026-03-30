#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod env-pod -n cm-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: env-pod not Running"
  exit 1
fi
VAL=$(kubectl exec env-pod -n cm-lab -- printenv APP_ENV 2>/dev/null)
if [ "$VAL" != "production" ]; then
  echo "FAIL: APP_ENV should be production inside the pod"
  exit 1
fi
if [ ! -f /root/app-env-value.txt ]; then
  echo "FAIL: /root/app-env-value.txt not found"
  exit 1
fi
echo "PASS"
exit 0
