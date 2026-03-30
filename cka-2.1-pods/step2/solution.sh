#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: init-pod
  namespace: practice
spec:
  initContainers:
  - name: wait-for-svc
    image: busybox:1.36
    command: ['sh', '-c', 'until nslookup myservice.practice.svc.cluster.local; do echo waiting; sleep 2; done']
  containers:
  - name: app
    image: nginx:1.25
EOF

# Create the service to unblock the init container
kubectl create service clusterip myservice --tcp=80:80 -n practice 2>/dev/null || true
kubectl wait --for=condition=Ready pod/init-pod -n practice --timeout=60s
