#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace exam-practice
# Create pods needing fixes
kubectl run fix-me-1 --image=nginx -n exam-practice --overrides='{"spec":{"containers":[{"name":"fix-me-1","image":"nginx","securityContext":{"privileged":true}}]}}'
kubectl run fix-me-2 --image=nginx -n exam-practice --overrides='{"spec":{"containers":[{"name":"fix-me-2","image":"nginx","securityContext":{"runAsUser":0}}]}}'
kubectl create serviceaccount exam-sa -n exam-practice
echo "Setup complete."
