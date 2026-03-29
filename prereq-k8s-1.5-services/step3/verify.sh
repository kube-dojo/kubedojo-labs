#!/bin/bash
# Verify service web-nodeport exists and is NodePort type
kubectl get svc web-nodeport > /dev/null 2>&1 || exit 1
TYPE=$(kubectl get svc web-nodeport -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$TYPE" = "NodePort" ] || exit 1
exit 0
