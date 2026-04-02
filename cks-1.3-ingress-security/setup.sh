#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace ingress-lab
kubectl run web-app --image=nginx --port=80 -n ingress-lab
kubectl expose pod web-app --port=80 -n ingress-lab
kubectl wait --for=condition=Ready pod/web-app -n ingress-lab --timeout=60s
echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
