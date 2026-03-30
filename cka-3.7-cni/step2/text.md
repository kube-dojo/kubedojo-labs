## CNI Configuration

CNI plugins are configured through JSON files in `/etc/cni/net.d/`. The kubelet reads these files to determine how to set up networking for new pods.

### Task

1. Copy the current CNI configuration to `/root/cni-config-backup.json`
2. Examine the pod CIDR range configured on the node
3. Verify the cluster CIDR by inspecting the kube-controller-manager configuration

```bash
# Backup the CNI config
cp /etc/cni/net.d/*.conflist /root/cni-config-backup.json 2>/dev/null || cp /etc/cni/net.d/*.conf /root/cni-config-backup.json

# Check the node's pod CIDR
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.podCIDR}{"\n"}{end}'

# Check kube-controller-manager for cluster CIDR
cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep cluster-cidr

# Examine kubelet CNI settings
ps aux | grep kubelet | tr ' ' '\n' | grep cni
```

<details>
<summary>Hint: CNI config key fields</summary>

Important fields in a CNI conflist:
- `cniVersion`: CNI spec version
- `name`: network name
- `plugins[].type`: plugin binary to call
- `plugins[].ipam`: IP address management config
- `plugins[].ipam.subnet`: pod IP range

```bash
# Pretty-print the config
cat /etc/cni/net.d/*.conflist | python3 -m json.tool 2>/dev/null || cat /etc/cni/net.d/*.conflist
```
</details>
