#!/bin/bash
# Check namespace
kubectl get namespace exam-sim > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: Namespace exam-sim does not exist"
  exit 1
fi

# Check pod task1
for i in $(seq 1 30); do
  S=$(kubectl get pod task1 -n exam-sim -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: Pod task1 not running"
  exit 1
fi

# Check deployment task2
R=$(kubectl get deployment task2 -n exam-sim -o jsonpath='{.spec.replicas}' 2>/dev/null)
if [ "$R" != "2" ]; then
  echo "FAIL: Deployment task2 should have 2 replicas"
  exit 1
fi

# Check configmap task3
VAL=$(kubectl get configmap task3 -n exam-sim -o jsonpath='{.data.ENV}' 2>/dev/null)
if [ "$VAL" != "production" ]; then
  echo "FAIL: ConfigMap task3 should have ENV=production"
  exit 1
fi

# Check service task4
SVC_IP=$(kubectl get svc task4 -n exam-sim -o jsonpath='{.spec.clusterIP}' 2>/dev/null)
if [ -z "$SVC_IP" ]; then
  echo "FAIL: Service task4 does not exist"
  exit 1
fi

# Check IP file
if [ ! -f /root/task4-ip.txt ]; then
  echo "FAIL: /root/task4-ip.txt does not exist"
  exit 1
fi
FILE_IP=$(cat /root/task4-ip.txt | tr -d '[:space:]')
if [ "$FILE_IP" != "$SVC_IP" ]; then
  echo "FAIL: IP mismatch. Service has $SVC_IP, file has $FILE_IP"
  exit 1
fi

echo "PASS: Timed challenge complete"
exit 0
