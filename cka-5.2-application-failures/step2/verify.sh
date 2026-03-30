#!/bin/bash
# Verify: image-pod is Running
POD_STATUS=$(kubectl get pod image-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$POD_STATUS" = "Running" ] && exit 0 || exit 1
