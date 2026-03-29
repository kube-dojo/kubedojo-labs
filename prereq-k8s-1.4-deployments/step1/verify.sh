#!/bin/bash
# Verify deployment "webapp" exists with 3 ready replicas
kubectl get deployment webapp > /dev/null 2>&1 || exit 1
READY=$(kubectl get deployment webapp -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
[ "$READY" = "3" ] || exit 1
exit 0
