#!/bin/bash
# Verify: pod is Running and Ready with both probes configured
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod probe-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  READY=$(kubectl get pod probe-pod -n practice -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}' 2>/dev/null)
  LIVENESS=$(kubectl get pod probe-pod -n practice -o jsonpath='{.spec.containers[0].livenessProbe.httpGet.port}' 2>/dev/null)
  READINESS=$(kubectl get pod probe-pod -n practice -o jsonpath='{.spec.containers[0].readinessProbe.httpGet.port}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && [ "$READY" = "True" ] && [ "$LIVENESS" = "80" ] && [ "$READINESS" = "80" ] && exit 0
  sleep 2
done
exit 1
