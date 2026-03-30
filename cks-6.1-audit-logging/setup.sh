#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace audit-lab
mkdir -p /var/log/kubernetes/audit
mkdir -p /etc/kubernetes/audit
cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-backup.yaml
echo "Setup complete."
