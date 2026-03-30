#!/bin/bash
kubectl config view -o jsonpath='{.clusters[0].name}' > /root/cluster-name.txt
echo "Cluster name:"
cat /root/cluster-name.txt
echo ""
echo ""
echo "Full kubeadm config:"
kubectl get configmap kubeadm-config -n kube-system -o yaml | head -30
