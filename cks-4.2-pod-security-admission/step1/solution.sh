#!/bin/bash
kubectl create namespace psa-privileged
kubectl create namespace psa-baseline
kubectl create namespace psa-restricted

kubectl label namespace psa-privileged pod-security.kubernetes.io/enforce=privileged
kubectl label namespace psa-baseline pod-security.kubernetes.io/enforce=baseline
kubectl label namespace psa-restricted pod-security.kubernetes.io/enforce=restricted

{
  echo "=== psa-privileged ==="
  kubectl get namespace psa-privileged --show-labels
  echo "=== psa-baseline ==="
  kubectl get namespace psa-baseline --show-labels
  echo "=== psa-restricted ==="
  kubectl get namespace psa-restricted --show-labels
} > /root/psa-labels.txt

{
  echo "=== Privileged pod in psa-privileged ==="
  kubectl run priv-test --image=nginx -n psa-privileged --overrides='{"spec":{"containers":[{"name":"nginx","image":"nginx","securityContext":{"privileged":true}}]}}' 2>&1 && echo "SUCCESS" || echo "FAILED"
  echo "=== Privileged pod in psa-baseline ==="
  kubectl run priv-test --image=nginx -n psa-baseline --overrides='{"spec":{"containers":[{"name":"nginx","image":"nginx","securityContext":{"privileged":true}}]}}' 2>&1 && echo "SUCCESS" || echo "FAILED"
  echo "=== Privileged pod in psa-restricted ==="
  kubectl run priv-test --image=nginx -n psa-restricted --overrides='{"spec":{"containers":[{"name":"nginx","image":"nginx","securityContext":{"privileged":true}}]}}' 2>&1 && echo "SUCCESS" || echo "FAILED"
} > /root/psa-deployment-test.txt

# Wait for pods that succeeded
kubectl wait --for=condition=Ready pod/priv-test -n psa-privileged --timeout=60s 2>/dev/null || true
