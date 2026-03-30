#!/bin/bash
# Verify: pod status is Succeeded
for i in $(seq 1 30); do
  PHASE=$(kubectl get pod lifecycle-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$PHASE" = "Succeeded" ] && exit 0
  sleep 2
done
exit 1
