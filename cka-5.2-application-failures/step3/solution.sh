#!/bin/bash
kubectl delete pod oom-pod -n practice --force --grace-period=0 2>/dev/null
sleep 2
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: oom-pod
  namespace: practice
spec:
  containers:
  - name: stress
    image: polinux/stress:latest
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "200M", "--vm-hang", "1"]
    resources:
      limits:
        memory: "256Mi"
      requests:
        memory: "256Mi"
EOF
sleep 10
kubectl get pod oom-pod -n practice
