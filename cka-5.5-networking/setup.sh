#!/bin/bash
# Setup script — pre-break networking

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

# Create namespaces
kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace isolated --dry-run=client -o yaml | kubectl apply -f -

# Problem 1: Pod with broken DNS (custom dnsPolicy)
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: dns-broken
  namespace: practice
spec:
  dnsPolicy: None
  dnsConfig:
    nameservers:
    - 1.2.3.4
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
EOF

# Problem 2: Service with wrong selector
kubectl run backend --image=nginx:1.25 -n practice --labels="app=backend,version=v1" --port=80
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: backend-svc
  namespace: practice
spec:
  selector:
    app: wrong-label
  ports:
  - port: 80
    targetPort: 80
EOF

# Problem 3: Two pods for connectivity test
kubectl run pod-a --image=nginx:1.25 -n practice --labels="app=pod-a"
kubectl run pod-b --image=busybox:1.36 -n practice -- sleep 3600

# Problem 4: NetworkPolicy blocking all traffic in isolated namespace
kubectl run web --image=nginx:1.25 -n isolated --labels="app=web" --port=80
kubectl expose pod web -n isolated --port=80
cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
  namespace: isolated
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
EOF

# Wait for pods
kubectl wait --for=condition=Ready pod --all -n practice --timeout=60s 2>/dev/null
kubectl wait --for=condition=Ready pod --all -n isolated --timeout=60s 2>/dev/null

echo "Kubernetes cluster ready. Broken networking resources created."
