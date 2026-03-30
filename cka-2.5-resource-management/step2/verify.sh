#!/bin/bash
# Verify: LimitRange exists in quota-test namespace
LR=$(kubectl get limitrange default-limits -n quota-test -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$LR" = "default-limits" ] && exit 0 || exit 1
