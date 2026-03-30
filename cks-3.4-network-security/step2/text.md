# Restrict Host Namespace and Network Access

Prevent pods from accessing host resources like the host network, PID namespace, or IPC namespace.

## Task

1. Create a pod named `isolated-pod` in `host-lab` with:
   - `hostNetwork: false`
   - `hostPID: false`
   - `hostIPC: false`
2. Create a pod named `hostnet-pod` in `host-lab` with `hostNetwork: true` (for comparison).
3. Compare the network interfaces visible in each pod:
   - Save `isolated-pod` interfaces to `/root/isolated-interfaces.txt`
   - Save `hostnet-pod` interfaces to `/root/hostnet-interfaces.txt`
4. Document in `/root/host-namespace-risks.txt` the security risks of each host namespace setting.

## Hint

Use `kubectl exec <pod> -- ip addr` or `cat /proc/net/dev` to list interfaces. Host network pods see all host interfaces.
