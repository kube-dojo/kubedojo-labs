#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace secrets-lab
echo "Setup complete."
