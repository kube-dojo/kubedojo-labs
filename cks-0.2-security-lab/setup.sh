#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
echo 'alias kn="kubectl -n"' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace security-lab
echo "Setup complete."
