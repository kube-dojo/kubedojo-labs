#!/bin/bash
FILE="/root/nginx-deploy.yaml"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

# Verify using kubectl to ensure it's a valid Deployment
if ! kubectl apply -f "$FILE" --dry-run=client > /dev/null 2>&1; then
  echo "FAIL: $FILE is not a valid Kubernetes manifest"
  exit 1
fi

# Check for replicas and image using grep (safer than python in kind node)
if grep -q "kind: Deployment" "$FILE" && \
   grep -q "replicas: 2" "$FILE" && \
   grep -q "image: nginx" "$FILE"; then
  echo "PASS: /root/nginx-deploy.yaml is a valid Deployment with 2 replicas"
  exit 0
else
  echo "FAIL: YAML is missing required fields (Deployment, replicas: 2, or nginx image)"
  exit 1
fi
