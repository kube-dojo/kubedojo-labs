#!/bin/bash
TYPE=$(kubectl get svc web-nodeport -n svc-lab -o jsonpath='{.spec.type}' 2>/dev/null)
if [ "$TYPE" != "NodePort" ]; then
  echo "FAIL: web-nodeport should be NodePort type"
  exit 1
fi
if [ ! -f /root/node-port.txt ]; then
  echo "FAIL: /root/node-port.txt not found"
  exit 1
fi
NP=$(cat /root/node-port.txt | tr -d '[:space:]')
if [ "$NP" -lt 30000 ] || [ "$NP" -gt 32767 ]; then
  echo "FAIL: NodePort should be in range 30000-32767"
  exit 1
fi
echo "PASS"
exit 0
