#!/bin/bash
# Verify deployment "webapp" exists with 3 ready replicas
# Wait up to 60s for all replicas to become ready
kubectl get deployment webapp > /dev/null 2>&1 || exit 1
for i in $(seq 1 30); do
  READY=$(kubectl get deployment webapp -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  if [ "$READY" = "3" ]; then
    exit 0
  fi
  sleep 2
done
exit 1
