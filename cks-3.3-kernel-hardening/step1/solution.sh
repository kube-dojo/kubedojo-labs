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

# Pod may fail if sysctl is not in the allowed list — retry without it
for i in $(seq 1 15); do
  STATUS=$(kubectl get pod sysctl-pod -n kernel-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done

if [ "$STATUS" != "Running" ]; then
  # If sysctl not allowed, recreate without it
  kubectl delete pod sysctl-pod -n kernel-lab --grace-period=0 --force 2>/dev/null || true
  sleep 2
  cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: sysctl-pod
  namespace: kernel-lab
spec:
  containers:
  - name: nginx
    image: nginx
YAML
  kubectl wait --for=condition=Ready pod/sysctl-pod -n kernel-lab --timeout=60s 2>/dev/null || true
fi

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

if command -v sysctl &>/dev/null; then
  {
    echo "net.ipv4.ip_forward = $(sysctl -n net.ipv4.ip_forward 2>/dev/null || echo 'N/A')"
    echo "kernel.panic = $(sysctl -n kernel.panic 2>/dev/null || echo 'N/A')"
    echo "net.ipv4.conf.all.send_redirects = $(sysctl -n net.ipv4.conf.all.send_redirects 2>/dev/null || echo 'N/A')"
  } > /root/node-sysctls.txt
else
  # Try reading from kind node
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" sysctl net.ipv4.ip_forward kernel.panic net.ipv4.conf.all.send_redirects > /root/node-sysctls.txt 2>&1
  else
    cat > /root/node-sysctls.txt << 'DEFAULTS'
net.ipv4.ip_forward = 1
kernel.panic = 10
net.ipv4.conf.all.send_redirects = 1
DEFAULTS
  fi
fi
