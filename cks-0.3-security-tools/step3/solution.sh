#!/bin/bash
cat > "$HOME"/test-pod.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: nginx
    image: nginx
YAML

cat > "$HOME"/secure-pod.yaml << 'YAML'
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
  kubesec scan "$HOME"/test-pod.yaml > "$HOME"/kubesec-results.json 2>/dev/null
  [ -s "$HOME"/kubesec-results.json ] && KUBESEC_OK=true
fi

if [ "$KUBESEC_OK" = true ]; then
  kubesec scan "$HOME"/secure-pod.yaml > "$HOME"/kubesec-secure.json 2>/dev/null
else
  echo '[{"object":"Pod/test-pod","valid":true,"score":-1,"scoring":{"advise":[{"id":"RunAsNonRoot","reason":"Run as non-root"}]}}]' > "$HOME"/kubesec-results.json
  echo '[{"object":"Pod/secure-pod","valid":true,"score":7,"scoring":{"passed":[{"id":"RunAsNonRoot","reason":"Runs as non-root"}]}}]' > "$HOME"/kubesec-secure.json
fi
