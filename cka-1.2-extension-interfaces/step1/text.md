# Container Runtime Interface (CRI)

The CRI defines how the kubelet communicates with the container runtime. Modern Kubernetes clusters use **containerd** or **CRI-O** (Docker shim was removed in K8s 1.24).

**Ways to identify the container runtime:**
- `kubectl get nodes -o wide` — shows the CONTAINER-RUNTIME column
- `kubectl describe node <name>` — look for `Container Runtime Version`
- `crictl info` — query the runtime directly

## Task

Identify which container runtime the cluster uses and save the name (e.g., `containerd` or `cri-o`) to `/root/container-runtime.txt`.

## Hint

Run `kubectl get nodes -o wide` and look at the CONTAINER-RUNTIME column. Alternatively, `kubectl describe node $(kubectl get nodes -o jsonpath='{.items[0].metadata.name}') | grep "Container Runtime"`.
