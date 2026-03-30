#!/bin/bash
cat > /root/pod-insecure.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: insecure
spec:
  containers:
  - name: nginx
    image: nginx
YAML

cat > /root/pod-baseline.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: baseline
spec:
  containers:
  - name: nginx
    image: nginx
    securityContext:
      runAsNonRoot: true
      runAsUser: 1000
YAML

cat > /root/pod-hardened.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: hardened
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: nginx
    image: nginx
    securityContext:
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
    resources:
      limits:
        memory: "128Mi"
        cpu: "250m"
      requests:
        memory: "64Mi"
        cpu: "125m"
YAML

kubesec scan /root/pod-insecure.yaml > /root/kubesec-insecure.json 2>&1
kubesec scan /root/pod-baseline.yaml > /root/kubesec-baseline.json 2>&1
kubesec scan /root/pod-hardened.yaml > /root/kubesec-hardened.json 2>&1

{
  echo "Insecure: $(cat /root/kubesec-insecure.json | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null || echo 'N/A')"
  echo "Baseline: $(cat /root/kubesec-baseline.json | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null || echo 'N/A')"
  echo "Hardened: $(cat /root/kubesec-hardened.json | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null || echo 'N/A')"
} > /root/kubesec-scores.txt
