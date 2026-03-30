#!/bin/bash
OUTPUT=$(kubectl kustomize /root/base/ 2>&1)
if [ $? -eq 0 ] && echo "$OUTPUT" | grep -q "kind"; then
  echo "PASS: kubectl kustomize /root/base/ produces valid YAML"
  exit 0
else
  echo "FAIL: kubectl kustomize /root/base/ failed: $OUTPUT"
  exit 1
fi
