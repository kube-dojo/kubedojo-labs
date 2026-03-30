#!/bin/bash
# Try Docker test if available
if command -v docker &> /dev/null; then
  echo "Testing seccomp profile with Docker..."
  docker run --rm --security-opt seccomp=/root/seccomp-profile.json alpine chmod 777 /tmp 2>&1 || echo "Expected: chmod blocked by seccomp"
else
  echo "Docker not available, skipping container test"
fi

# Create Kubernetes manifest
cat > /root/k8s-seccomp.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-demo
  labels:
    app: seccomp-demo
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: nginx
    image: nginx:1.27
    securityContext:
      seccompProfile:
        type: Localhost
        localhostProfile: profiles/no-chmod.json
    ports:
    - containerPort: 80
    resources:
      requests:
        memory: "64Mi"
        cpu: "100m"
      limits:
        memory: "128Mi"
        cpu: "200m"
EOF

echo "Kubernetes seccomp manifest created at /root/k8s-seccomp.yaml"
