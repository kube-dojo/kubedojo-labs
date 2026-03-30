#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod always-pull -n images-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done

PP1=$(kubectl get pod always-pull -n images-lab -o jsonpath='{.spec.containers[0].imagePullPolicy}' 2>/dev/null)
if [ "$PP1" != "Always" ]; then
  echo "FAIL: always-pull should have imagePullPolicy=Always, got: $PP1"
  exit 1
fi

PP2=$(kubectl get pod ifnotpresent-pull -n images-lab -o jsonpath='{.spec.containers[0].imagePullPolicy}' 2>/dev/null)
if [ "$PP2" != "IfNotPresent" ]; then
  echo "FAIL: ifnotpresent-pull should have imagePullPolicy=IfNotPresent, got: $PP2"
  exit 1
fi

if [ ! -f /root/pull-policy.txt ]; then
  echo "FAIL: /root/pull-policy.txt does not exist"
  exit 1
fi
CONTENT=$(cat /root/pull-policy.txt | tr -d '[:space:]')
if [ "$CONTENT" != "Always" ]; then
  echo "FAIL: pull-policy.txt should contain Always, got: $CONTENT"
  exit 1
fi

echo "PASS"
exit 0
