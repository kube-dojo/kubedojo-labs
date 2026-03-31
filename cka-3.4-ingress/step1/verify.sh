#!/bin/bash
# Verify: NGINX ingress controller pod is running
for i in $(seq 1 30); do
  if kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller --field-selector=status.phase=Running -o name 2>/dev/null | grep -q "pod/"; then exit 0; fi
  sleep 2
done
exit 1
