#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: quota-lab
spec:
  hard:
    requests.cpu: "1"
    requests.memory: "1Gi"
    pods: "5"
YAML

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: quota-pod
  namespace: quota-lab
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    resources:
      requests:
        cpu: "200m"
        memory: "128Mi"
YAML
kubectl wait --for=condition=Ready pod/quota-pod -n quota-lab --timeout=60s
kubectl get resourcequota compute-quota -n quota-lab -o jsonpath='{.status.used.requests\.cpu}' > /root/used-cpu.txt
