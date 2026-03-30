#!/bin/bash
# Verify: broken-pod is Running with correct image
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod broken-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  IMAGE=$(kubectl get pod broken-pod -n practice -o jsonpath='{.spec.containers[0].image}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && [[ "$IMAGE" == *"nginx"* ]] && exit 0
  sleep 2
done
exit 1
