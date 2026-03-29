#!/bin/bash
# Verify service web-svc exists and is ClusterIP type
kubectl get svc web-svc > /dev/null 2>&1 || exit 1
TYPE=$(kubectl get svc web-svc -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$TYPE" = "ClusterIP" ] || exit 1
exit 0
