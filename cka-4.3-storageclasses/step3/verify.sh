#!/bin/bash
# Verify: fast-local is default and default-pvc is bound
IS_DEFAULT=$(kubectl get sc fast-local -o jsonpath='{.metadata.annotations.storageclass\.kubernetes\.io/is-default-class}' 2>/dev/null)
PVC_SC=$(kubectl get pvc default-pvc -n practice -o jsonpath='{.spec.storageClassName}' 2>/dev/null)
PVC_STATUS=$(kubectl get pvc default-pvc -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$IS_DEFAULT" = "true" ] && [ "$PVC_STATUS" = "Bound" ] && exit 0 || exit 1
