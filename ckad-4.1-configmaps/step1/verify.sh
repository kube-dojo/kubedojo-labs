#!/bin/bash
VAL=$(kubectl get configmap app-config -n cm-lab -o jsonpath='{.data.APP_ENV}' 2>/dev/null)
if [ "$VAL" != "production" ]; then
  echo "FAIL: app-config should have APP_ENV=production"
  exit 1
fi
kubectl get configmap file-config -n cm-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: file-config ConfigMap not found"
  exit 1
fi
if [ ! -f /root/cm-data.txt ]; then
  echo "FAIL: /root/cm-data.txt not found"
  exit 1
fi
echo "PASS"
exit 0
