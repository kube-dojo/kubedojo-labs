#!/bin/bash
# Verify: webapp deployment is available with all replicas ready
for i in $(seq 1 30); do
  AVAILABLE=$(kubectl get deployment webapp -n practice -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
  DESIRED=$(kubectl get deployment webapp -n practice -o jsonpath='{.spec.replicas}' 2>/dev/null)
  [ "$AVAILABLE" = "$DESIRED" ] && [ -n "$AVAILABLE" ] && [ "$AVAILABLE" -ge 1 ] && exit 0
  sleep 2
done
exit 1
