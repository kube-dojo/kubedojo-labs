#!/bin/bash
BLUE=$(kubectl get deployment blue-app -n strategy-lab -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
GREEN=$(kubectl get deployment green-app -n strategy-lab -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
if [ "$BLUE" != "3" ] || [ "$GREEN" != "3" ]; then
  echo "FAIL: Both blue and green should have 3 ready replicas"
  exit 1
fi

SEL_VER=$(kubectl get svc myapp-svc -n strategy-lab -o jsonpath='{.spec.selector.version}' 2>/dev/null)
if [ "$SEL_VER" != "green" ]; then
  echo "FAIL: Service should select version=green, got: $SEL_VER"
  exit 1
fi

if [ ! -f /root/active-version.txt ]; then
  echo "FAIL: /root/active-version.txt not found"
  exit 1
fi
echo "PASS"
exit 0
