#!/bin/bash
cp /etc/cni/net.d/*.conflist /root/cni-config-backup.json 2>/dev/null || cp /etc/cni/net.d/*.conf /root/cni-config-backup.json 2>/dev/null
echo "=== Node Pod CIDR ==="
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.podCIDR}{"\n"}{end}'
echo "=== Cluster CIDR ==="
cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep cluster-cidr || echo "Not found in manifest"
