#!/bin/bash
# Verify: debug-copy pod exists
kubectl get pod debug-copy -n practice -o jsonpath='{.metadata.name}' 2>/dev/null | grep -q "debug-copy" && exit 0 || exit 1
