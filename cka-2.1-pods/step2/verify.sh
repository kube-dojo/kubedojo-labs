#!/bin/bash
# Verify: init-pod is running with init container completed
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod init-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && exit 0
  sleep 2
done
exit 1
