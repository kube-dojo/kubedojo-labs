#!/bin/bash
ss -tlnp > /root/listening-ports.txt
systemctl list-units --type=service --state=running > /root/running-services.txt

cat > /root/port-analysis.txt << 'ANALYSIS'
6443 - kube-apiserver - ESSENTIAL
2379 - etcd client - ESSENTIAL
2380 - etcd peer - ESSENTIAL
10250 - kubelet - ESSENTIAL
10259 - kube-scheduler - ESSENTIAL
10257 - kube-controller-manager - ESSENTIAL
22 - sshd - REQUIRED for management
53 - coredns - ESSENTIAL for DNS
ANALYSIS

cat > /root/k8s-ports.txt << 'PORTS'
6443 - API server (HTTPS)
2379-2380 - etcd (client and peer)
10250 - kubelet API (HTTPS)
10259 - kube-scheduler (HTTPS)
10257 - kube-controller-manager (HTTPS)
PORTS
