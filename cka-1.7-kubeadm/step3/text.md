# Cluster Upgrade Preparation

Before upgrading a cluster, you should always run `kubeadm upgrade plan` to see:

- The current cluster version
- Available upgrade targets
- Any components that need manual upgrading

**Upgrade workflow (for reference):**
1. `kubeadm upgrade plan` — check available versions
2. `kubeadm upgrade apply v1.X.Y` — upgrade control plane
3. Upgrade kubelet and kubectl on each node
4. Drain, upgrade, and uncordon worker nodes

## Task

Run `kubeadm upgrade plan` and save the output to `/root/upgrade-plan.txt`.

This is a read-only operation and will not modify your cluster.

<details>
<summary>Hint</summary>

```bash
kubeadm upgrade plan > /root/upgrade-plan.txt 2>&1
```
</details>