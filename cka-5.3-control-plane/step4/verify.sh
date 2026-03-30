#!/bin/bash
# Verify: scheduler is running and test pod is Running
SCHED=$(kubectl get pods -n kube-system -l component=kube-scheduler --field-selector=status.phase=Running -o name 2>/dev/null | head -1)
POD_STATUS=$(kubectl get pod scheduler-test -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
[ -n "$SCHED" ] && [ "$POD_STATUS" = "Running" ] && exit 0 || exit 1
