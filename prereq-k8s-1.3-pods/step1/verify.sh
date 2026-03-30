#!/bin/bash
# Verify pod "web" exists and is Running
# Wait up to 60s for the pod to reach Running state (image pull may take time)
for i in $(seq 1 30); do
  if kubectl get pod web -o jsonpath='{.status.phase}' 2>/dev/null | grep -q "Running"; then
    exit 0
  fi
  sleep 2
done
exit 1
