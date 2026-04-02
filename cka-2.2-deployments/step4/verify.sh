#!/bin/bash
PAUSED=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.paused}' 2>/dev/null)
if [ "$PAUSED" = "true" ]; then
  echo "FAIL: Deployment is still paused"
  exit 1
fi

DEP=$(kubectl get deployment web-deploy -n practice -o json 2>/dev/null)
IMAGE=$(echo "$DEP" | jq -r '.spec.template.spec.containers[0].image')
LIMIT_CPU=$(echo "$DEP" | jq -r '.spec.template.spec.containers[0].resources.limits.cpu')

if [ "$IMAGE" = "nginx:1.27" ] && [ "$LIMIT_CPU" = "200m" ]; then
  # Wait for rollout
  AVAIL=$(echo "$DEP" | jq -r '.status.availableReplicas')
  if [ "$AVAIL" -ge 3 ]; then
    echo "PASS: Multiple changes applied and rolled out after resume"
    exit 0
  else
    echo "FAIL: Changes applied but pods are not yet available ($AVAIL)"
    exit 1
  fi
else
  echo "FAIL: Multiple changes not found. Found Image: $IMAGE, CPU Limit: $LIMIT_CPU"
  exit 1
fi