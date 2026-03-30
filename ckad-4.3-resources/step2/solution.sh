#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
  namespace: resources-lab
spec:
  limits:
  - type: Container
    default:
      cpu: "500m"
      memory: "256Mi"
    defaultRequest:
      cpu: "100m"
      memory: "64Mi"
YAML
kubectl run auto-limits --image=nginx:1.25 -n resources-lab
kubectl wait --for=condition=Ready pod/auto-limits -n resources-lab --timeout=60s
kubectl get pod auto-limits -n resources-lab -o jsonpath='{.spec.containers[0].resources.limits.cpu}' > /root/auto-cpu-limit.txt
