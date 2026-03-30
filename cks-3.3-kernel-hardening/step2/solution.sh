#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: no-caps
  namespace: kernel-lab
spec:
  containers:
  - name: nginx
    image: nginx
    securityContext:
      capabilities:
        drop: ["ALL"]
---
apiVersion: v1
kind: Pod
metadata:
  name: net-caps
  namespace: kernel-lab
spec:
  containers:
  - name: nginx
    image: nginx
    securityContext:
      capabilities:
        drop: ["ALL"]
        add: ["NET_BIND_SERVICE"]
YAML
kubectl wait --for=condition=Ready pod/no-caps -n kernel-lab --timeout=60s 2>&1 || true
kubectl wait --for=condition=Ready pod/net-caps -n kernel-lab --timeout=60s 2>&1 || true

cat > /root/default-caps.txt << 'CAPS'
Default Docker/containerd capabilities:
CHOWN, DAC_OVERRIDE, FSETID, FOWNER, MKNOD, NET_RAW, SETGID, SETUID,
SETFCAP, SETPCAP, NET_BIND_SERVICE, SYS_CHROOT, KILL, AUDIT_WRITE
CAPS

{
  echo "=== no-caps pod ==="
  kubectl exec no-caps -n kernel-lab -- cat /proc/1/status 2>/dev/null | grep Cap || echo "Cannot read capabilities"
  echo ""
  echo "=== net-caps pod ==="
  kubectl exec net-caps -n kernel-lab -- cat /proc/1/status 2>/dev/null | grep Cap || echo "Cannot read capabilities"
} > /root/caps-comparison.txt
