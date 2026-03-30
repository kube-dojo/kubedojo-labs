#!/bin/bash
if kubectl get deployment 2>/dev/null | grep -q "prod-"; then
  echo "PASS: Deployment with 'prod-' prefix exists"
  exit 0
else
  echo "FAIL: No deployment with 'prod-' prefix found"
  exit 1
fi
