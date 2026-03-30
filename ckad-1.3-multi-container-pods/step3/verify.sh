#!/bin/bash
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod adapter-pod -n multi-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: adapter-pod not Running"
  exit 1
fi

CONTAINERS=$(kubectl get pod adapter-pod -n multi-lab -o jsonpath='{.spec.containers[*].name}' 2>/dev/null)
if [[ "$CONTAINERS" != *"app"* ]] || [[ "$CONTAINERS" != *"transformer"* ]]; then
  echo "FAIL: Should have containers app and transformer"
  exit 1
fi

# Give time for data to flow
sleep 8
RAW=$(kubectl exec adapter-pod -n multi-lab -c app -- cat /metrics/raw.log 2>/dev/null | head -1)
if [ -z "$RAW" ]; then
  echo "FAIL: raw.log should have content"
  exit 1
fi

echo "PASS"
exit 0
