#!/bin/bash
kubectl version > /root/current-version.txt 2>&1

if command -v kubeadm &>/dev/null; then
  kubeadm upgrade plan > /root/upgrade-plan.txt 2>&1
else
  cat > /root/upgrade-plan.txt << 'PLAN'
kubeadm not directly available (kind cluster).
In a kubeadm-managed cluster, 'kubeadm upgrade plan' would show:
  Components that need upgrading
  Available upgrade versions
  Required manual steps
PLAN
fi

if command -v apt &>/dev/null; then
  apt list -a kubeadm > /root/available-versions.txt 2>/dev/null
else
  echo "apt not available (kind cluster) — versions managed by kind" > /root/available-versions.txt
fi

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
