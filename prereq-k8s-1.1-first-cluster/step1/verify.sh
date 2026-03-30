#!/bin/bash
# Verify that at least one node is in Ready state
# Works with any cluster (kind, kubeadm, etc.) regardless of node naming
for i in $(seq 1 30); do
  if kubectl get nodes --no-headers 2>/dev/null | grep -q " Ready"; then
    # If the user also saved a node name file, validate it
    if [ -f /root/node-name.txt ]; then
      NODE_NAME=$(cat /root/node-name.txt | tr -d '[:space:]')
      [ -z "$NODE_NAME" ] && exit 1
      kubectl get node "$NODE_NAME" > /dev/null 2>&1 || exit 1
    fi
    exit 0
  fi
  sleep 2
done
exit 1
