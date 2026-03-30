#!/bin/bash
kubectl version > /root/current-version.txt 2>&1
kubeadm upgrade plan > /root/upgrade-plan.txt 2>&1
apt list -a kubeadm > /root/available-versions.txt 2>/dev/null || echo "apt not available" > /root/available-versions.txt

cat > /root/upgrade-checklist.txt << 'CHECKLIST'
1. Backup etcd data before starting the upgrade
2. Read the changelog for the target version — check for breaking changes
3. Verify all nodes are Ready before starting
4. Upgrade only one minor version at a time
5. Upgrade control plane first, then worker nodes
6. Drain nodes before upgrading kubelet
7. Verify all system pods are running after each step
8. Test application functionality after upgrade
CHECKLIST
