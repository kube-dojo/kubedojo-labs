#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace metadata-lab
kubectl run test-pod --image=nginx -n metadata-lab
kubectl wait --for=condition=Ready pod/test-pod -n metadata-lab --timeout=60s
echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
