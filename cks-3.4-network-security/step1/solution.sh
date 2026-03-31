#!/bin/bash
# Try ss locally or in kind node
if command -v ss &>/dev/null; then
  ss -tlnp > /root/listening-ports.txt 2>&1
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" ss -tlnp > /root/listening-ports.txt 2>&1 || docker exec "$NODE" netstat -tlnp > /root/listening-ports.txt 2>&1
  else
    echo "ss/netstat not available — typical K8s listening ports listed below" > /root/listening-ports.txt
  fi
fi

if command -v systemctl &>/dev/null; then
  systemctl list-units --type=service --state=running > /root/running-services.txt 2>&1
else
  # In kind, list running services from the node
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" ps aux > /root/running-services.txt 2>&1
  else
    echo "kubelet, kube-apiserver, etcd, kube-controller-manager, kube-scheduler, containerd" > /root/running-services.txt
  fi
fi

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
