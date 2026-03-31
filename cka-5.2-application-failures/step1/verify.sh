#!/bin/bash
# Verify: crash-pod is Running
for i in $(seq 1 30); do
  POD_STATUS=$(kubectl get pod crash-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$POD_STATUS" = "Running" ] && exit 0
  sleep 2
done
exit 1
