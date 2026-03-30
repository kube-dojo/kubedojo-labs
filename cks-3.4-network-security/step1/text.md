# Minimize Host OS Attack Surface

Kubernetes nodes should run only essential services. Audit and document the current state.

## Task

1. List all listening ports on the node: `ss -tlnp` and save to `/root/listening-ports.txt`.
2. List all running services: `systemctl list-units --type=service --state=running` and save to `/root/running-services.txt`.
3. Identify which ports are Kubernetes-related and which are non-essential. Save your analysis to `/root/port-analysis.txt` with format:
   ```
   PORT - SERVICE - ESSENTIAL/NON-ESSENTIAL
   ```
4. Save the list of essential K8s ports to `/root/k8s-ports.txt`:
   - 6443 (API server), 2379-2380 (etcd), 10250 (kubelet), 10259 (scheduler), 10257 (controller-manager)

## Hint

Use `ss -tlnp | grep -v kube` to find non-Kubernetes services. Ports like SSH (22) may be needed but should be restricted.
