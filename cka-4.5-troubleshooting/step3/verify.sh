#!/bin/bash
# Verify: broken-mount-pod is Running with correct PVC
for i in $(seq 1 30); do
  POD_STATUS=$(kubectl get pod broken-mount-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  PVC_NAME=$(kubectl get pod broken-mount-pod -n practice -o jsonpath='{.spec.volumes[0].persistentVolumeClaim.claimName}' 2>/dev/null)
  [ "$POD_STATUS" = "Running" ] && [ "$PVC_NAME" = "correct-pvc" ] && exit 0
  sleep 2
done
exit 1
