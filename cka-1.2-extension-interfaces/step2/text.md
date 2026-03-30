# Container Network Interface (CNI)

The CNI plugin provides pod networking. Common plugins include Calico, Flannel, Cilium, and Weave Net.

**Ways to identify the CNI plugin:**
- Check `/etc/cni/net.d/` for configuration files
- Look for CNI-related pods in `kube-system` namespace
- Check the kubelet `--cni-conf-dir` flag

## Task

Identify the CNI plugin used by the cluster and save the name to `/root/cni-plugin.txt`.

Check both `/etc/cni/net.d/` directory and CNI-related pods in `kube-system`.

## Hint

Run `ls /etc/cni/net.d/` to see CNI config files. Also check `kubectl get pods -n kube-system` for pods with names like `calico`, `flannel`, `cilium`, or `weave`.
