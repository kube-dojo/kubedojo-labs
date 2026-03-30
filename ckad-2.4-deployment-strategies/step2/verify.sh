#!/bin/bash
TYPE=$(kubectl get deployment recreate-app -n strategy-lab -o jsonpath='{.spec.strategy.type}' 2>/dev/null)
if [ "$TYPE" != "Recreate" ]; then
  echo "FAIL: Strategy should be Recreate, got: $TYPE"
  exit 1
fi
IMG=$(kubectl get deployment recreate-app -n strategy-lab -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
if [ "$IMG" != "httpd:2.4.59" ]; then
  echo "FAIL: Image should be httpd:2.4.59"
  exit 1
fi
if [ ! -f /root/recreate-strategy.txt ]; then
  echo "FAIL: /root/recreate-strategy.txt not found"
  exit 1
fi
echo "PASS"
exit 0
