#!/bin/bash
# Verify: projected-pod exists with projected volume containing 3 sources
POD=$(kubectl get pod projected-pod -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
SOURCE_COUNT=$(kubectl get pod projected-pod -n practice -o jsonpath='{.spec.volumes[0].projected.sources}' 2>/dev/null | grep -c "configMap\|secret\|downwardAPI")
[ "$POD" = "projected-pod" ] && [ "$SOURCE_COUNT" -ge 3 ] && exit 0 || exit 1
