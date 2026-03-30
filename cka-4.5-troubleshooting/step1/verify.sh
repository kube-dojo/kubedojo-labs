#!/bin/bash
# Verify: broken-pvc-class is now Bound
STATUS=$(kubectl get pvc broken-pvc-class -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$STATUS" = "Bound" ] && exit 0 || exit 1
