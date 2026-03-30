# Understand Container Runtime Classes

RuntimeClass lets you select different container runtimes for different workloads.

## Task

1. Check the current container runtime on the node: `kubectl get nodes -o jsonpath='{.items[0].status.nodeInfo.containerRuntimeVersion}'`. Save to `/root/current-runtime.txt`.
2. List any existing RuntimeClass resources: `kubectl get runtimeclass`. Save to `/root/existing-runtimeclasses.txt`.
3. Create `/root/runtime-comparison.txt` comparing three runtimes:
   - **runc**: Default OCI runtime, shares host kernel
   - **gVisor (runsc)**: User-space kernel, intercepts syscalls
   - **Kata Containers**: Lightweight VMs with dedicated kernels
4. Document when each runtime is appropriate.

## Hint

Use `crictl info` or check the kubelet configuration for the container runtime endpoint.
