#!/bin/bash
OUTPUT=$(kubectl kustomize /root/base/ 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: kubectl kustomize /root/base/ failed"
  exit 1
fi

if echo "$OUTPUT" | grep -q "image: nginx:1.27" && echo "$OUTPUT" | grep -q "kind: Service"; then
  echo "PASS: Base kustomization verified with correct image and resources"
  exit 0
else
  echo "FAIL: Base kustomization output is missing expected resources or image version"
  exit 1
fi