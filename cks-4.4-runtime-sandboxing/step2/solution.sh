#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: gvisor
handler: runsc
---
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: kata
handler: kata-qemu
YAML

cat > /root/sandboxed-pod.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: sandboxed-pod
  namespace: sandbox-lab
spec:
  runtimeClassName: gvisor
  containers:
  - name: nginx
    image: nginx
    securityContext:
      runAsNonRoot: true
      runAsUser: 1000
YAML

kubectl get runtimeclass -o yaml > /root/runtimeclasses.yaml
