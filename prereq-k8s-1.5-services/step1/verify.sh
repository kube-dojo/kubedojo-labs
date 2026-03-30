#!/bin/bash
# Verify service web-svc exists and is ClusterIP type
# Wait up to 60s for the service to be created
for i in $(seq 1 30); do
  if kubectl get svc web-svc > /dev/null 2>&1; then
    TYPE=$(kubectl get svc web-svc -o jsonpath='{.spec.type}' 2>/dev/null)
    if [ "$TYPE" = "ClusterIP" ]; then
      exit 0
    fi
  fi
  sleep 2
done
exit 1
