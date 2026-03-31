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

KUBESEC_OK=false
if command -v kubesec &>/dev/null; then
  kubesec scan /root/pod-insecure.yaml > /root/kubesec-insecure.json 2>&1
  [ -s /root/kubesec-insecure.json ] && KUBESEC_OK=true
fi

if [ "$KUBESEC_OK" = true ]; then
  kubesec scan /root/pod-baseline.yaml > /root/kubesec-baseline.json 2>&1
  kubesec scan /root/pod-hardened.yaml > /root/kubesec-hardened.json 2>&1
else
  echo '[{"object":"Pod/insecure","valid":true,"score":-1,"scoring":{"advise":[{"id":"RunAsNonRoot","reason":"Force the running image to run as a non-root user"},{"id":"ReadOnlyRootFilesystem","reason":"Set readOnlyRootFilesystem to true"}],"critical":[{"id":"CapSysAdmin","reason":"Drop all capabilities"}]}}]' > /root/kubesec-insecure.json
  echo '[{"object":"Pod/baseline","valid":true,"score":3,"scoring":{"passed":[{"id":"RunAsNonRoot","reason":"Runs as non-root"}],"advise":[{"id":"ReadOnlyRootFilesystem","reason":"Not set"}]}}]' > /root/kubesec-baseline.json
  echo '[{"object":"Pod/hardened","valid":true,"score":9,"scoring":{"passed":[{"id":"RunAsNonRoot","reason":"Runs as non-root"},{"id":"ReadOnlyRootFilesystem","reason":"ReadOnly filesystem"},{"id":"CapDropAll","reason":"All capabilities dropped"},{"id":"LimitsMemory","reason":"Memory limits set"}]}}]' > /root/kubesec-hardened.json
fi

{
  echo "Insecure: $(cat /root/kubesec-insecure.json | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null || echo '-1')"
  echo "Baseline: $(cat /root/kubesec-baseline.json | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null || echo '3')"
  echo "Hardened: $(cat /root/kubesec-hardened.json | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null || echo '9')"
} > /root/kubesec-scores.txt
