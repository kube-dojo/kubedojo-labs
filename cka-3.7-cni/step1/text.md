## CNI Plugin Inspection

The Container Network Interface (CNI) is a standard for configuring networking in Linux containers. Kubernetes uses CNI plugins to set up pod networking.

### Task

1. Identify which CNI plugin is installed on this cluster
2. List the CNI binary files in `/opt/cni/bin/`
3. Save the name of the active CNI plugin to `/root/cni-plugin.txt`

```bash
# Check CNI configuration directory
ls /etc/cni/net.d/

# Read the primary CNI config
cat /etc/cni/net.d/*.conflist 2>/dev/null || cat /etc/cni/net.d/*.conf 2>/dev/null

# List available CNI binaries
ls /opt/cni/bin/

# Check which CNI-related pods are running
kubectl get pods -n kube-system | grep -E "calico|flannel|weave|cilium"

# Check the node's pod CIDR
kubectl get node -o jsonpath='{.items[0].spec.podCIDR}'
```

Save the CNI plugin name:

```bash
# Determine the plugin name and save it
echo "weave" > /root/cni-plugin.txt  # or calico, flannel, etc.
```

<details>
<summary>Hint: Finding the CNI plugin</summary>

```bash
# The CNI config file reveals the plugin
cat /etc/cni/net.d/*.conflist | grep -i type | head -3

# The kube-system namespace contains CNI pods
kubectl get pods -n kube-system -o wide

# kubelet config also references CNI
ps aux | grep kubelet | grep cni
```
</details>
