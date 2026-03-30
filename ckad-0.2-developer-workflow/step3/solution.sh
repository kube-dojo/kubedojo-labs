#!/bin/bash
kubectl get deployment webapp -n dev-workflow -o yaml > /root/webapp.yaml
sed -i 's/nginx:1.24/nginx:1.25/' /root/webapp.yaml
sed -i 's/replicas: 2/replicas: 4/' /root/webapp.yaml
kubectl diff -f /root/webapp.yaml -n dev-workflow || true
kubectl apply -f /root/webapp.yaml -n dev-workflow
kubectl rollout status deployment/webapp -n dev-workflow --timeout=60s
