#!/bin/bash
sudo cp /etc/cni/net.d/*.conflist "$HOME"/cni-config-backup.json 2>/dev/null || sudo cp /etc/cni/net.d/*.conf "$HOME"/cni-config-backup.json 2>/dev/null
echo "=== Node Pod CIDR ==="
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.podCIDR}{"\n"}{end}'
echo "=== Cluster CIDR ==="
cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep cluster-cidr || echo "Not found in manifest"
