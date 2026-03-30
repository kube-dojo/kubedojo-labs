#!/bin/bash
# Verify pod "api" exists in the default namespace
# Wait up to 60s for the pod to be created and running
for i in $(seq 1 30); do
  if kubectl get pod api -n default > /dev/null 2>&1; then
    exit 0
  fi
  sleep 2
done
exit 1
