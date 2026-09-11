#!/bin/bash
kubectl get deployment webapp -n dev-workflow -o yaml > "$HOME"/webapp.yaml
sed -i 's/nginx:1.24/nginx:1.25/' "$HOME"/webapp.yaml
sed -i 's/replicas: 2/replicas: 4/' "$HOME"/webapp.yaml
kubectl diff -f "$HOME"/webapp.yaml -n dev-workflow || true
kubectl apply -f "$HOME"/webapp.yaml -n dev-workflow
kubectl rollout status deployment/webapp -n dev-workflow --timeout=60s
