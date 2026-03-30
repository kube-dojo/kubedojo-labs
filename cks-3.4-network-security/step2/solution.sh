#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: isolated-pod
  namespace: host-lab
spec:
  hostNetwork: false
  hostPID: false
  hostIPC: false
  containers:
  - name: nginx
    image: nginx
---
apiVersion: v1
kind: Pod
metadata:
  name: hostnet-pod
  namespace: host-lab
spec:
  hostNetwork: true
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 8080
YAML
kubectl wait --for=condition=Ready pod/isolated-pod -n host-lab --timeout=60s
kubectl wait --for=condition=Ready pod/hostnet-pod -n host-lab --timeout=60s
kubectl exec isolated-pod -n host-lab -- cat /proc/net/dev > /root/isolated-interfaces.txt 2>&1 || echo "Cannot list" > /root/isolated-interfaces.txt
kubectl exec hostnet-pod -n host-lab -- cat /proc/net/dev > /root/hostnet-interfaces.txt 2>&1 || echo "Cannot list" > /root/hostnet-interfaces.txt

cat > /root/host-namespace-risks.txt << 'RISKS'
hostNetwork: true — pod shares host network stack, can see all traffic, bind to any port, access services on localhost
hostPID: true — pod can see all processes on the host, enabling process inspection and signal sending
hostIPC: true — pod shares IPC namespace, can access shared memory segments of other processes
All three should be false for normal workloads to maintain isolation.
RISKS
