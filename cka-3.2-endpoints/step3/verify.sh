#!/bin/bash
# Verify: headless service exists with clusterIP None and StatefulSet has 3 replicas
CLUSTER_IP=$(kubectl get svc db-headless -n practice -o jsonpath='{.spec.clusterIP}' 2>/dev/null)
REPLICAS=$(kubectl get statefulset db -n practice -o jsonpath='{.spec.replicas}' 2>/dev/null)
[ "$CLUSTER_IP" = "None" ] && [ "$REPLICAS" = "3" ] && exit 0 || exit 1
