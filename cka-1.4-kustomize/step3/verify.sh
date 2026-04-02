#!/bin/bash
# Check for deployment
if ! kubectl get deployment prod-myapp >/dev/null 2>&1; then
  echo "FAIL: Deployment 'prod-myapp' not found"
  exit 1
fi

# Check for replicas
REPLICAS=$(kubectl get deployment prod-myapp -o jsonpath='{.spec.replicas}')
if [ "$REPLICAS" -eq 3 ]; then
  echo "PASS: Deployment 'prod-myapp' found with 3 replicas"
  exit 0
else
  echo "FAIL: Deployment 'prod-myapp' has $REPLICAS replicas (expected 3)"
  exit 1
fi