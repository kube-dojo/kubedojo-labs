#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
  namespace: resources-lab
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    resources:
      requests:
        cpu: "100m"
        memory: "64Mi"
      limits:
        cpu: "200m"
        memory: "128Mi"
YAML
kubectl wait --for=condition=Ready pod/resource-pod -n resources-lab --timeout=60s
kubectl get pod resource-pod -n resources-lab -o jsonpath='{.spec.containers[0].resources.limits.cpu}' > /root/cpu-limit.txt
