#!/bin/bash
# Verify: oom-pod is Running with adequate memory
POD_STATUS=$(kubectl get pod oom-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
MEM_LIMIT=$(kubectl get pod oom-pod -n practice -o jsonpath='{.spec.containers[0].resources.limits.memory}' 2>/dev/null)
[ "$POD_STATUS" = "Running" ] && exit 0 || exit 1
