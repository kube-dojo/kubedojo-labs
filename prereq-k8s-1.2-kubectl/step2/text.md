## Step 2: Describe Resources

`kubectl describe` gives you detailed information about a specific resource — much more than `get`.

### Describe the node

```bash
kubectl describe node controlplane
```

This outputs a wall of text. Here's what to look for:

| Section | What it tells you |
|---------|-------------------|
| **Labels** | Metadata tags on the node |
| **Conditions** | Is the node Ready, under pressure, etc. |
| **Capacity** | Total CPU, memory, pods the node can handle |
| **Allocatable** | Resources available after system reservations |
| **System Info** | OS, kernel, kubelet version, container runtime |
| **Non-terminated Pods** | What's running on this node right now |

### Find a specific detail

You can pipe through `grep` to find exactly what you need:

```bash
kubectl describe node controlplane | grep "Kubelet Version"
```

### Your task

Find the kubelet version running on your node and save it to:

```
/root/kubelet-version.txt
```

The file should contain just the version string (e.g., `v1.31.0`).

<details>
<summary>Hint</summary>

```bash
kubectl get node controlplane -o jsonpath='{.status.nodeInfo.kubeletVersion}' > /root/kubelet-version.txt
```

Or using describe and grep:

```bash
kubectl describe node controlplane | grep "Kubelet Version" | awk '{print $NF}' > /root/kubelet-version.txt
```
</details>
