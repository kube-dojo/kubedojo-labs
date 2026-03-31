#!/bin/bash
kubectl apply -k /root/overlays/prod/

# Wait for deployments to roll out
for deploy in $(kubectl get deployments -o name 2>/dev/null); do
  kubectl rollout status "$deploy" --timeout=120s 2>/dev/null || true
done
echo ""
echo "Deployments:"
kubectl get deployments
echo ""
echo "Pods:"
kubectl get pods
