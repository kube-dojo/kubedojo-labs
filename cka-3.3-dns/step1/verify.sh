#!/bin/bash
# Verify: CoreDNS configmap contains custom hosts entry
kubectl get configmap coredns -n kube-system -o jsonpath='{.data.Corefile}' 2>/dev/null | grep -q "custom.example.com" && exit 0 || exit 1
