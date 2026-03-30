#!/bin/bash
# Verify: pod can read ConfigMap values from /etc/config
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod config-vol-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  if [ "$STATUS" = "Running" ]; then
    VALUE=$(kubectl exec config-vol-pod -n practice -- cat /etc/config/APP_ENV 2>/dev/null)
    [ "$VALUE" = "production" ] && exit 0
  fi
  sleep 2
done
exit 1
