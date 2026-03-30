#!/bin/bash
kubectl delete pod readiness-pod -n practice --force --grace-period=0 2>/dev/null
sleep 2
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: readiness-pod
  namespace: practice
  labels:
    app: readiness-test
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5
EOF
kubectl wait --for=condition=Ready pod/readiness-pod -n practice --timeout=60s
kubectl get endpoints readiness-svc -n practice
