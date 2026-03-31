#!/bin/bash
kubectl run lifecycle-pod --image=busybox:1.36 -n practice \
  --restart=Never -- sh -c 'echo "Task complete"; exit 0' 2>/dev/null || true
# Wait for pod to complete
for i in $(seq 1 30); do
  PHASE=$(kubectl get pod lifecycle-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$PHASE" = "Succeeded" ] && break
  sleep 2
done
