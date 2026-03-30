#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace metadata-lab
kubectl run test-pod --image=nginx -n metadata-lab
kubectl wait --for=condition=Ready pod/test-pod -n metadata-lab --timeout=60s
echo "Setup complete."
