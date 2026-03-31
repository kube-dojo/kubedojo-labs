#!/bin/bash
kubectl run web --image=nginx:1.25 -n ckad-practice
kubectl create deployment api --image=httpd:2.4 --replicas=3 -n ckad-practice
kubectl run generator --image=busybox:1.36 --dry-run=client -o yaml -- sleep 3600 > /root/generator.yaml
kubectl apply -f /root/generator.yaml -n ckad-practice

# Wait for resources to be ready
kubectl wait --for=condition=Ready pod/web -n ckad-practice --timeout=120s 2>/dev/null || true
kubectl rollout status deployment/api -n ckad-practice --timeout=120s 2>/dev/null || true
kubectl wait --for=condition=Ready pod/generator -n ckad-practice --timeout=120s 2>/dev/null || true
