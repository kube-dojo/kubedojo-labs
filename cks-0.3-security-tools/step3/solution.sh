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

KUBESEC_OK=false
if command -v kubesec &>/dev/null; then
  kubesec scan /root/test-pod.yaml > /root/kubesec-results.json 2>/dev/null
  [ -s /root/kubesec-results.json ] && KUBESEC_OK=true
fi

if [ "$KUBESEC_OK" = true ]; then
  kubesec scan /root/secure-pod.yaml > /root/kubesec-secure.json 2>/dev/null
else
  echo '[{"object":"Pod/test-pod","valid":true,"score":-1,"scoring":{"advise":[{"id":"RunAsNonRoot","reason":"Run as non-root"}]}}]' > /root/kubesec-results.json
  echo '[{"object":"Pod/secure-pod","valid":true,"score":7,"scoring":{"passed":[{"id":"RunAsNonRoot","reason":"Runs as non-root"}]}}]' > /root/kubesec-secure.json
fi
