#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc
cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-original.yaml
echo "Setup complete."
