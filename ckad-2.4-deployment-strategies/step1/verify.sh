#!/bin/bash
TYPE=$(kubectl get deployment rolling-app -n strategy-lab -o jsonpath='{.spec.strategy.type}' 2>/dev/null)
if [ "$TYPE" != "RollingUpdate" ]; then
  echo "FAIL: Strategy should be RollingUpdate, got: $TYPE"
  exit 1
fi
SURGE=$(kubectl get deployment rolling-app -n strategy-lab -o jsonpath='{.spec.strategy.rollingUpdate.maxSurge}' 2>/dev/null)
if [ "$SURGE" != "1" ]; then
  echo "FAIL: maxSurge should be 1, got: $SURGE"
  exit 1
fi
UNAVAIL=$(kubectl get deployment rolling-app -n strategy-lab -o jsonpath='{.spec.strategy.rollingUpdate.maxUnavailable}' 2>/dev/null)
if [ "$UNAVAIL" != "0" ]; then
  echo "FAIL: maxUnavailable should be 0, got: $UNAVAIL"
  exit 1
fi
IMG=$(kubectl get deployment rolling-app -n strategy-lab -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
if [ "$IMG" != "nginx:1.25" ]; then
  echo "FAIL: Image should be nginx:1.25 after update"
  exit 1
fi
if [ ! -f /root/strategy-type.txt ]; then
  echo "FAIL: /root/strategy-type.txt not found"
  exit 1
fi
echo "PASS"
exit 0
