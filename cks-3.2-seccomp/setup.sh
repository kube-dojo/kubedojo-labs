#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace seccomp-lab
mkdir -p /var/lib/kubelet/seccomp/profiles
echo "Setup complete."
