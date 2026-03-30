#!/bin/bash
# Verify pod "api" no longer exists
# Wait up to 60s for the pod to be fully terminated
for i in $(seq 1 30); do
  if ! kubectl get pod api > /dev/null 2>&1; then
    exit 0
  fi
  sleep 2
done
exit 1
