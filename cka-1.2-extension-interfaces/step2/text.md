# Container Network Interface (CNI)

The CNI plugin provides pod networking. Common plugins include Calico, Flannel, Cilium, and Weave Net.

**Ways to identify the CNI plugin:**
- Check `/etc/cni/net.d/` for configuration files
- Look for CNI-related pods in `kube-system` namespace
- Check the kubelet `--cni-conf-dir` flag

## Task

Identify the CNI plugin used by the cluster and save the name to `/root/cni-plugin.txt`.

Check both `/etc/cni/net.d/` directory and CNI-related pods in `kube-system`.

<details>
<summary>Hint</summary>

Run `ls /etc/cni/net.d/` to see CNI config files. 
```bash
ls /etc/cni/net.d/ | head -1 > /root/cni-plugin.txt
```
</details>