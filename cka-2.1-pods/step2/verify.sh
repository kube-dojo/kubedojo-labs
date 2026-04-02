#!/bin/bash
# 1. Check if pod is running
STATUS=$(kubectl get pod init-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: Pod init-pod is not Running. Current status: $STATUS"
  exit 1
fi

# 2. Check if Service exists
if ! kubectl get svc myservice -n practice >/dev/null 2>&1; then
  echo "FAIL: Service 'myservice' not found. The pod needs it to finish init."
  exit 1
fi

# 3. Check for init container success
READY=$(kubectl get pod init-pod -n practice -o jsonpath='{.status.initContainerStatuses[0].ready}')
if [ "$READY" = "true" ]; then
  echo "PASS: init-pod is running and dependency was met"
  exit 0
else
  echo "FAIL: Init container did not complete successfully"
  exit 1
fi