#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace rbac-lab
kubectl create namespace production
kubectl create serviceaccount app-deployer -n rbac-lab
kubectl create serviceaccount log-reader -n rbac-lab
kubectl create serviceaccount secret-admin -n rbac-lab
echo "Setup complete."
