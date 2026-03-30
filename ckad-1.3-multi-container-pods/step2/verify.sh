#!/bin/bash
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod sidecar-log -n multi-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: sidecar-log not Running"
  exit 1
fi

CONTAINERS=$(kubectl get pod sidecar-log -n multi-lab -o jsonpath='{.spec.containers[*].name}' 2>/dev/null)
if [[ "$CONTAINERS" != *"app"* ]] || [[ "$CONTAINERS" != *"log-reader"* ]]; then
  echo "FAIL: Pod should have containers 'app' and 'log-reader', got: $CONTAINERS"
  exit 1
fi

# Wait a few seconds for logs
sleep 6
LOGS=$(kubectl logs sidecar-log -n multi-lab -c log-reader --tail=1 2>/dev/null)
if [ -z "$LOGS" ]; then
  echo "FAIL: log-reader sidecar should have log output"
  exit 1
fi

echo "PASS"
exit 0
