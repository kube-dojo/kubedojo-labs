#!/bin/bash
# Verify: NGINX ingress controller pod is running
kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller --field-selector=status.phase=Running -o name 2>/dev/null | grep -q "pod/" && exit 0 || exit 1
