#!/bin/bash
# Verify: pod exists with PVC mounted
POD=$(kubectl get pod pvc-pod -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
CLAIM=$(kubectl get pod pvc-pod -n practice -o jsonpath='{.spec.volumes[0].persistentVolumeClaim.claimName}' 2>/dev/null)
[ "$POD" = "pvc-pod" ] && [ "$CLAIM" = "pvc-app" ] && exit 0 || exit 1
