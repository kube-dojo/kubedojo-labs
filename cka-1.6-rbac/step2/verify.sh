#!/bin/bash
if kubectl get clusterrole node-viewer 2>/dev/null; then
  echo "PASS: ClusterRole node-viewer exists"
  exit 0
else
  echo "FAIL: ClusterRole node-viewer not found"
  exit 1
fi
