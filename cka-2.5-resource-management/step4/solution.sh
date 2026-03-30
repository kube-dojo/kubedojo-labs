#!/bin/bash
kubectl run quota-pod-1 --image=nginx:1.25 -n quota-test 2>/dev/null || true
kubectl run quota-pod-2 --image=nginx:1.25 -n quota-test 2>/dev/null || true
# This should fail due to quota
kubectl run quota-pod-3 --image=nginx:1.25 -n quota-test 2>/dev/null || echo "Expected: quota exceeded"
kubectl wait --for=condition=Ready pod/quota-pod-1 -n quota-test --timeout=60s 2>/dev/null
kubectl wait --for=condition=Ready pod/quota-pod-2 -n quota-test --timeout=60s 2>/dev/null
