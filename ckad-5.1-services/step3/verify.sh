#!/bin/bash
CIP=$(kubectl get svc web-headless -n svc-lab -o jsonpath='{.spec.clusterIP}' 2>/dev/null)
if [ "$CIP" != "None" ]; then
  echo "FAIL: web-headless should have clusterIP=None, got: $CIP"
  exit 1
fi
if [ ! -f /root/headless-ip.txt ]; then
  echo "FAIL: /root/headless-ip.txt not found"
  exit 1
fi
echo "PASS"
exit 0
