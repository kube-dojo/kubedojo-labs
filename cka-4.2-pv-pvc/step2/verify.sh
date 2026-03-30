#!/bin/bash
# Verify: both PVCs exist and are Bound
STATUS1=$(kubectl get pvc pvc-app -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
STATUS2=$(kubectl get pvc pvc-shared -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$STATUS1" = "Bound" ] && [ "$STATUS2" = "Bound" ] && exit 0 || exit 1
