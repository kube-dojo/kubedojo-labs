#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: sysctl-pod
  namespace: kernel-lab
spec:
  securityContext:
    sysctls:
    - name: net.ipv4.ping_group_range
      value: "0 65535"
  containers:
  - name: nginx
    image: nginx
YAML
kubectl wait --for=condition=Ready pod/sysctl-pod -n kernel-lab --timeout=60s 2>&1 || true

cat > /root/safe-sysctls.txt << 'SAFE'
kernel.shm_rmid_forced
net.ipv4.ip_local_port_range
net.ipv4.tcp_syncookies
net.ipv4.ping_group_range
net.ipv4.ip_unprivileged_port_start
SAFE

cat > /root/unsafe-sysctls.txt << 'UNSAFE'
kernel.msg* (IPC namespace — may affect other pods)
kernel.sem (IPC namespace)
kernel.shm* (IPC namespace)
net.ipv4.ip_forward (host network — affects routing)
net.ipv4.conf.*.send_redirects (host network)
net.ipv4.conf.*.accept_redirects (host network)
UNSAFE

{
  echo "net.ipv4.ip_forward = $(sysctl -n net.ipv4.ip_forward)"
  echo "kernel.panic = $(sysctl -n kernel.panic)"
  echo "net.ipv4.conf.all.send_redirects = $(sysctl -n net.ipv4.conf.all.send_redirects)"
} > /root/node-sysctls.txt
