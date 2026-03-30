#!/bin/bash
# Verify: image is nginx:1.24 (revision 1)
for i in $(seq 1 30); do
  IMAGE=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
  [ "$IMAGE" = "nginx:1.24" ] && exit 0
  sleep 2
done
exit 1
