#!/bin/bash
# Verify: webapp deployment is available with all replicas ready
AVAILABLE=$(kubectl get deployment webapp -n practice -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
DESIRED=$(kubectl get deployment webapp -n practice -o jsonpath='{.spec.replicas}' 2>/dev/null)
[ "$AVAILABLE" = "$DESIRED" ] && [ "$AVAILABLE" -ge 1 ] && exit 0 || exit 1
