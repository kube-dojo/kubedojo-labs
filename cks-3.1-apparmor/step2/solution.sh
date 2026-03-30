#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: apparmor-pod
  namespace: apparmor-lab
  annotations:
    container.apparmor.security.beta.kubernetes.io/nginx: localhost/k8s-deny-write
spec:
  containers:
  - name: nginx
    image: nginx
YAML
kubectl wait --for=condition=Ready pod/apparmor-pod -n apparmor-lab --timeout=60s
kubectl exec apparmor-pod -n apparmor-lab -- sh -c 'touch /tmp/test 2>&1' > /root/write-test.txt 2>&1 || echo "Write denied by AppArmor (expected)" >> /root/write-test.txt
kubectl get pod apparmor-pod -n apparmor-lab -o jsonpath='{.metadata.annotations}' > /root/pod-apparmor.txt
