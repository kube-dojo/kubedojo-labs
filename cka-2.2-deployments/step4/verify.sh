#!/bin/bash
# Verify: deployment is not paused and has rolled out
PAUSED=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.paused}' 2>/dev/null)
# paused should be empty or false (not "true")
[ "$PAUSED" = "true" ] && exit 1

# Check rollout completed
for i in $(seq 1 30); do
  AVAILABLE=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
  DESIRED=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.replicas}' 2>/dev/null)
  [ "$AVAILABLE" = "$DESIRED" ] && [ -n "$AVAILABLE" ] && exit 0
  sleep 2
done
exit 1
