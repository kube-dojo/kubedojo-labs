#!/bin/bash
# Verify deployment image is nginx:1.26
# Wait up to 60s for the rollout to update the image
for i in $(seq 1 30); do
  IMAGE=$(kubectl get deployment webapp -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
  if [ "$IMAGE" = "nginx:1.26" ]; then
    exit 0
  fi
  sleep 2
done
exit 1
