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
kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.securityContext.runAsNonRoot}' > /root/nonroot-value.txt
kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.allowPrivilegeEscalation}' > /root/priv-escalation.txt
