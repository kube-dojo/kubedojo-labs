#!/bin/bash
grep "service-cluster-ip-range" /etc/kubernetes/manifests/kube-apiserver.yaml | awk -F'=' '{print $2}' | tr -d ' ' > /root/service-cidr.txt
echo "Service CIDR:"
cat /root/service-cidr.txt
