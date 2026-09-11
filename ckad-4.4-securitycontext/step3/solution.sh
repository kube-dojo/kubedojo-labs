#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: nonroot-pod
  namespace: security-lab
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
  containers:
  - name: nginx
    image: nginx:1.25
    securityContext:
      allowPrivilegeEscalation: false
YAML
# Wait for pod to be created (may not reach Ready if nginx needs root)
sleep 5
kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.securityContext.runAsNonRoot}' > "$HOME"/nonroot-value.txt
kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.allowPrivilegeEscalation}' > "$HOME"/priv-escalation.txt
