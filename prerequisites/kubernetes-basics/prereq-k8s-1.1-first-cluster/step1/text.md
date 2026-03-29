## Step 1: Explore the Cluster

You have a live Kubernetes cluster. Let's find out what's running.

### Check cluster info

```bash
kubectl cluster-info
```

This shows the API server address and CoreDNS. The API server is the "front door" to your cluster — every `kubectl` command talks to it.

### See the nodes

```bash
kubectl get nodes
```

A **node** is a machine (physical or virtual) that runs your workloads. In this lab, you have a single node acting as both the control plane and a worker.

Try with more details:

```bash
kubectl get nodes -o wide
```

The `-o wide` flag shows extra columns like the internal IP, OS, kernel version, and container runtime.

### List namespaces

```bash
kubectl get namespaces
```

Namespaces are like folders — they organize resources and can isolate teams or environments. Every cluster starts with `default`, `kube-system`, `kube-public`, and `kube-node-lease`.

### Your task

Save the name of your node to a file:

```
/root/node-name.txt
```

The file should contain only the node name (e.g., `controlplane`).

<details>
<summary>Hint</summary>

```bash
kubectl get nodes -o jsonpath='{.items[0].metadata.name}' > /root/node-name.txt
```

Or simply:

```bash
kubectl get nodes --no-headers -o custom-columns=':metadata.name' > /root/node-name.txt
```
</details>
