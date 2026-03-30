#!/bin/bash
# Verify: cache-pod has 2 containers and emptyDir volume
CONTAINER_COUNT=$(kubectl get pod cache-pod -n practice -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | wc -w)
VOL_TYPE=$(kubectl get pod cache-pod -n practice -o jsonpath='{.spec.volumes[0].emptyDir}' 2>/dev/null)
[ "$CONTAINER_COUNT" -eq 2 ] && [ -n "$VOL_TYPE" ] && exit 0 || exit 1
