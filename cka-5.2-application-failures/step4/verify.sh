#!/bin/bash
# Verify: readiness-pod is Ready and service has endpoints
for i in $(seq 1 30); do
  READY=$(kubectl get pod readiness-pod -n practice -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}' 2>/dev/null)
  ENDPOINTS=$(kubectl get endpoints readiness-svc -n practice -o jsonpath='{.subsets[0].addresses[0].ip}' 2>/dev/null)
  [ "$READY" = "True" ] && [ -n "$ENDPOINTS" ] && exit 0
  sleep 2
done
exit 1
