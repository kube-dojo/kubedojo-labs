# Upgrade the Control Plane

Practice the control plane upgrade procedure (dry-run only in this lab to preserve cluster stability).

## Task

1. Run a dry-run upgrade: `kubeadm upgrade plan` and identify the target version.
2. Save the target version to `/root/target-version.txt`.
3. Create `/root/upgrade-commands.txt` documenting the exact commands you would run for a real upgrade:
   - Update kubeadm package
   - Run kubeadm upgrade apply
   - Drain the node
   - Update kubelet and kubectl packages
   - Restart kubelet
   - Uncordon the node
4. Save the current etcd version to `/root/etcd-version.txt` (from the etcd pod or manifest).

## Hint

Check `/etc/kubernetes/manifests/etcd.yaml` for the etcd image version. The upgrade sequence is: kubeadm -> control plane -> drain -> kubelet/kubectl -> uncordon.
