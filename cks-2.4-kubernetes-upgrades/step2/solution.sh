#!/bin/bash
PLAN=$(kubeadm upgrade plan 2>&1)
echo "$PLAN" | grep -oP 'v\d+\.\d+\.\d+' | tail -1 > /root/target-version.txt

cat > /root/upgrade-commands.txt << 'COMMANDS'
# 1. Update kubeadm
apt-get update && apt-get install -y kubeadm=<target-version>

# 2. Verify upgrade plan
kubeadm upgrade plan

# 3. Apply the upgrade
kubeadm upgrade apply v<target-version>

# 4. Drain the node
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data

# 5. Update kubelet and kubectl
apt-get install -y kubelet=<target-version> kubectl=<target-version>

# 6. Restart kubelet
systemctl daemon-reload
systemctl restart kubelet

# 7. Uncordon the node
kubectl uncordon <node-name>
COMMANDS

grep 'image:' /etc/kubernetes/manifests/etcd.yaml | awk -F: '{print $NF}' > /root/etcd-version.txt
