#!/bin/bash
kubectl apply -k /root/overlays/prod/
echo ""
echo "Deployments:"
kubectl get deployments
echo ""
echo "Pods:"
kubectl get pods
