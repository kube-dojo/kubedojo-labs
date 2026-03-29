#!/bin/bash
# Verify deployment "webapp" has 5 ready replicas
READY=$(kubectl get deployment webapp -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
[ "$READY" = "5" ] || exit 1
exit 0
