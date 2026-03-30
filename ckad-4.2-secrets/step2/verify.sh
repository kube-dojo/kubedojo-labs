#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod secret-env-pod -n secrets-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
VAL=$(kubectl exec secret-env-pod -n secrets-lab -- printenv DB_USER 2>/dev/null)
if [ "$VAL" != "admin" ]; then
  echo "FAIL: DB_USER should be admin"
  exit 1
fi
VAL2=$(kubectl exec secret-env-pod -n secrets-lab -- printenv DB_PASS 2>/dev/null)
if [ "$VAL2" != "s3cur3P@ss" ]; then
  echo "FAIL: DB_PASS should be s3cur3P@ss"
  exit 1
fi
if [ ! -f /root/db-user.txt ]; then
  echo "FAIL: /root/db-user.txt not found"
  exit 1
fi
echo "PASS"
exit 0
