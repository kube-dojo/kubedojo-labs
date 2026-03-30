#!/bin/bash
kubectl get nodes -o jsonpath='{.items[0].status.nodeInfo.containerRuntimeVersion}' > /root/current-runtime.txt
kubectl get runtimeclass > /root/existing-runtimeclasses.txt 2>&1 || echo "No RuntimeClass resources found" > /root/existing-runtimeclasses.txt

cat > /root/runtime-comparison.txt << 'COMPARE'
runc (default):
- Shares host kernel directly
- Best performance, lowest overhead
- Suitable for trusted workloads
- Vulnerable to kernel exploits

gVisor (runsc):
- Runs a user-space kernel that intercepts syscalls
- ~200 of 300+ syscalls supported
- Higher overhead (2-10x for syscall-heavy workloads)
- Suitable for untrusted code, multi-tenant environments
- Cannot run all workloads (limited syscall support)

Kata Containers:
- Each pod runs in a lightweight VM with its own kernel
- Near-native performance for most workloads
- Stronger isolation than gVisor (full kernel boundary)
- Higher memory overhead (each VM needs its own kernel)
- Suitable for maximum isolation requirements
COMPARE
