#!/bin/bash
# Verify: headless service exists with clusterIP: None
CLUSTER_IP=$(kubectl get svc sts-svc -n practice -o jsonpath='{.spec.clusterIP}' 2>/dev/null)
[ "$CLUSTER_IP" = "None" ] && exit 0 || exit 1
