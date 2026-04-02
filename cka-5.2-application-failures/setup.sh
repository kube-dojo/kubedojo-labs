#!/bin/bash
# Setup script — pre-break things for troubleshooting

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

# Create practice namespace
kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f -

# Problem 1: CrashLoopBackOff — bad command
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: crash-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["/bin/sh", "-c", "exit 1"]
EOF

# Problem 2: ImagePullBackOff — wrong image
kubectl run image-pod --image=nginx:v999.999 -n practice 2>/dev/null || true

# Problem 3: OOMKilled — too little memory
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
        memory: "50Mi"
      requests:
        memory: "50Mi"
EOF

# Problem 4: Failing readiness probe — wrong port
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
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: readiness-svc
  namespace: practice
spec:
  selector:
    app: readiness-test
  ports:
  - port: 80
    targetPort: 80
EOF

echo "Kubernetes cluster ready. Broken pods created for troubleshooting."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
