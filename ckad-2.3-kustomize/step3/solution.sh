#!/bin/bash
kubectl apply -k /root/kustomize/overlays/staging/
kubectl apply -k /root/kustomize/overlays/production/
kubectl rollout status deployment/staging-myapp -n staging --timeout=60s
kubectl rollout status deployment/prod-myapp -n production --timeout=60s
kubectl get deployments -n staging -o jsonpath='{.items[0].metadata.name}' > /root/staging-deploy-name.txt
