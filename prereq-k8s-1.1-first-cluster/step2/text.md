## Step 2: Understand the Control Plane

Kubernetes has a **control plane** — a set of components that manage the entire cluster. They all run as pods in the `kube-system` namespace.

### List control plane pods

```bash
kubectl get pods -n kube-system
```

You should see pods like:

| Pod | Purpose |
|-----|---------|
| `etcd-*` | Key-value store — the cluster's database |
| `kube-apiserver-*` | API server — handles all REST requests |
| `kube-controller-manager-*` | Runs controllers (Deployment, ReplicaSet, etc.) |
| `kube-scheduler-*` | Decides which node runs each pod |
| `coredns-*` | DNS for service discovery inside the cluster |
| `kube-proxy-*` | Manages network rules on each node |

These are the building blocks. If any of them go down, parts of the cluster stop working.

### Count them

```bash
kubectl get pods -n kube-system --no-headers | wc -l
```

### Your task

Count the number of pods running in the `kube-system` namespace and save that number to:

```
/root/cp-pod-count.txt
```

The file should contain just the number (e.g., `7`).

<details>
<summary>Hint</summary>

```bash
kubectl get pods -n kube-system --no-headers | wc -l | tr -d ' ' > /root/cp-pod-count.txt
```
</details>
