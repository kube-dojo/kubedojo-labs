#!/bin/bash
kubectl get networkpolicy allow-web-ingress -n netpol-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: NetworkPolicy allow-web-ingress not found"
  exit 1
fi
TARGET=$(kubectl get networkpolicy allow-web-ingress -n netpol-lab -o jsonpath='{.spec.podSelector.matchLabels.app}' 2>/dev/null)
if [ "$TARGET" != "web" ]; then
  echo "FAIL: Policy should target app=web pods"
  exit 1
fi
FROM_LABEL=$(kubectl get networkpolicy allow-web-ingress -n netpol-lab -o jsonpath='{.spec.ingress[0].from[0].podSelector.matchLabels.tier}' 2>/dev/null)
if [ "$FROM_LABEL" != "frontend" ]; then
  echo "FAIL: Ingress should allow from tier=frontend"
  exit 1
fi
if [ ! -f /root/netpol-count.txt ]; then
  echo "FAIL: /root/netpol-count.txt not found"
  exit 1
fi
echo "PASS"
exit 0
