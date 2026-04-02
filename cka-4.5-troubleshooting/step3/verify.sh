#!/bin/bash
# High-integrity verification for Step 3
# 1. Check if pod exists
if ! kubectl get pod broken-mount-pod -n practice > /dev/null 2>&1; then
  echo "FAIL: Pod broken-mount-pod not found in namespace practice"
  exit 1
fi

# 2. Check for the correct PVC name regardless of volume order
PVC_NAME=$(kubectl get pod broken-mount-pod -n practice -o json | python3 -c "
import json, sys
pod = json.load(sys.stdin)
pvc = next((v['persistentVolumeClaim']['claimName'] for v in pod['spec']['volumes'] if 'persistentVolumeClaim' in v), None)
print(pvc if pvc else '')
")

if [ "$PVC_NAME" != "correct-pvc" ]; then
  echo "FAIL: Pod is not using 'correct-pvc'. Current PVC: $PVC_NAME"
  exit 1
fi

# 3. Wait for pod to be Running (Max 60s)
kubectl wait --for=condition=Ready pod/broken-mount-pod -n practice --timeout=60s > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "PASS: Pod is running and using the correct PVC."
  exit 0
else
  echo "FAIL: Pod is not Ready. Check 'kubectl describe pod broken-mount-pod -n practice' for errors."
  exit 1
fi
