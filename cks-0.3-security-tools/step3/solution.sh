#!/bin/bash
cat > /root/test-pod.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: nginx
    image: nginx
YAML
kubesec scan /root/test-pod.yaml > /root/kubesec-results.json

cat > /root/secure-pod.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  containers:
  - name: nginx
    image: nginx
    securityContext:
      runAsNonRoot: true
      runAsUser: 1000
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
YAML
kubesec scan /root/secure-pod.yaml > /root/kubesec-secure.json
