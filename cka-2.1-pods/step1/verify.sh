#!/bin/bash
# Verify: pod exists with 2 containers in practice namespace
CONTAINER_COUNT=$(kubectl get pod sidecar-pod -n practice -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | wc -w)
[ "$CONTAINER_COUNT" -eq 2 ] && exit 0 || exit 1
