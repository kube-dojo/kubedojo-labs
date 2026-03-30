# Explore Cluster Components

The Kubernetes control plane runs as pods in the `kube-system` namespace. Key components include:

- **kube-apiserver** — the front door to the cluster
- **etcd** — the key-value store for all cluster data
- **kube-scheduler** — assigns pods to nodes
- **kube-controller-manager** — runs controller loops
- **coredns** — cluster DNS

## Task

1. List all pods in the `kube-system` namespace.
2. Find the API server pod name.
3. Save the full pod name to `/root/apiserver-pod.txt`.

## Hint

The API server pod name typically starts with `kube-apiserver-`. Use `kubectl get pods -n kube-system` and look for it.
