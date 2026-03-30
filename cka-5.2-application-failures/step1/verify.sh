#!/bin/bash
# Verify: crash-pod is Running
POD_STATUS=$(kubectl get pod crash-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$POD_STATUS" = "Running" ] && exit 0 || exit 1
