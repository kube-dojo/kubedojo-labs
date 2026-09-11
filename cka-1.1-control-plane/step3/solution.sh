#!/bin/bash
sudo grep "service-cluster-ip-range" /etc/kubernetes/manifests/kube-apiserver.yaml | awk -F'=' '{print $2}' | tr -d ' ' > "$HOME"/service-cidr.txt
echo "Service CIDR:"
cat "$HOME"/service-cidr.txt
