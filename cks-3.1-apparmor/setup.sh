#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace apparmor-lab
# Ensure AppArmor is available
apt-get update -qq && apt-get install -y -qq apparmor-utils 2>/dev/null || true
echo "Setup complete."
