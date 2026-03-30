#!/bin/bash
cat > /root/base/deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: nginx
        image: nginx:1.27
        ports:
        - containerPort: 80
EOF

cat > /root/base/service.yaml << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: myapp
spec:
  type: ClusterIP
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 80
EOF

cat > /root/base/kustomization.yaml << 'EOF'
resources:
  - deployment.yaml
  - service.yaml
EOF

echo "Base kustomization output:"
kubectl kustomize /root/base/
