#!/bin/bash
# Verify: PVC is bound and pod is running
PVC_STATUS=$(kubectl get pvc dynamic-pvc -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
POD_STATUS=$(kubectl get pod dynamic-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PVC_STATUS" = "Bound" ] && [ "$POD_STATUS" = "Running" ] && exit 0 || exit 1
