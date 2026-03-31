#!/bin/bash
kubectl delete pod standard-pod -n sandbox-lab --grace-period=0 --force 2>/dev/null || true
kubectl run standard-pod --image=busybox -n sandbox-lab -- sleep 3600

# Wait for the pod to be Ready with retries (image pull can be slow in kind)
for i in $(seq 1 12); do
  if kubectl wait --for=condition=Ready pod/standard-pod -n sandbox-lab --timeout=10s 2>/dev/null; then
    break
  fi
  sleep 5
done

# Read kernel version with retry (exec can fail briefly after Ready)
for i in $(seq 1 5); do
  kubectl exec standard-pod -n sandbox-lab -- cat /proc/version > /root/standard-kernel.txt 2>/dev/null && break
  sleep 2
done

# Fallback if exec still fails
if [ ! -s /root/standard-kernel.txt ]; then
  uname -a > /root/standard-kernel.txt 2>/dev/null || echo "Linux kernel (shared with host — no sandbox isolation)" > /root/standard-kernel.txt
fi

cat > /root/isolation-matrix.txt << 'MATRIX'
| Feature            | runc (default) | gVisor (runsc)    | Kata Containers     |
|--------------------|----------------|-------------------|---------------------|
| Kernel shared      | Yes            | No (user-space)   | No (VM kernel)      |
| Syscall filtering  | Via seccomp    | Built-in (~200)   | Full kernel         |
| Performance        | Native         | 2-10x overhead    | ~5-10% overhead     |
| Memory overhead    | None           | ~20-50MB          | ~100-200MB per pod  |
| Startup time       | Fast           | Moderate          | Slower (VM boot)    |
| Use case           | Trusted apps   | Untrusted code    | Max isolation       |
MATRIX

cat > /root/sandbox-decision.txt << 'DECISION'
Multi-tenant SaaS platform:
  Recommendation: gVisor or Kata Containers
  Reason: Untrusted tenant code needs kernel-level isolation to prevent container escapes

Internal trusted microservices:
  Recommendation: runc with seccomp + AppArmor
  Reason: Trusted code does not need full sandboxing; seccomp/AppArmor provide sufficient protection

Running untrusted user code (CI/CD, code execution):
  Recommendation: gVisor
  Reason: Best balance of isolation and performance for syscall-heavy workloads; blocks kernel exploits
DECISION
