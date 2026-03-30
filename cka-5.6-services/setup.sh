#!/bin/bash
# Setup script — pre-break services

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

# Create practice namespace
kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f -

# Problem 1: Service with mismatched selector (no endpoints)
kubectl run api-server --image=nginx:1.25 -n practice --labels="app=api,version=v2" --port=80
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: api-svc
  namespace: practice
spec:
  selector:
    app: api
    version: v1
  ports:
  - port: 80
    targetPort: 80
EOF

# Problem 2: Service with wrong targetPort
kubectl run web-app --image=nginx:1.25 -n practice --labels="app=web-app" --port=80
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: web-svc
  namespace: practice
spec:
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 8080
EOF

# Problem 3: NodePort service with wrong type
kubectl run public-app --image=nginx:1.25 -n practice --labels="app=public" --port=80
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: public-svc
  namespace: practice
spec:
  type: ClusterIP
  selector:
    app: public
  ports:
  - port: 80
    targetPort: 80
EOF

# Wait for pods
kubectl wait --for=condition=Ready pod --all -n practice --timeout=60s 2>/dev/null

echo "Kubernetes cluster ready. Broken services created."
