#!/bin/bash
# Patch CoreDNS ConfigMap to add hosts block
COREFILE=$(kubectl get configmap coredns -n kube-system -o jsonpath='{.data.Corefile}')
NEW_COREFILE=$(echo "$COREFILE" | sed '/ready/i\
    hosts {\
        1.2.3.4 custom.example.com\
        fallthrough\
    }')
kubectl get configmap coredns -n kube-system -o json | \
  jq --arg cf "$NEW_COREFILE" '.data.Corefile = $cf' | \
  kubectl apply -f -
kubectl rollout restart deployment coredns -n kube-system
kubectl rollout status deployment coredns -n kube-system --timeout=60s
