#!/bin/bash
cat > /root/overlays/prod/replica-patch.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
EOF

cat > /root/overlays/prod/kustomization.yaml << 'EOF'
resources:
  - ../../base
namePrefix: prod-
patches:
  - path: replica-patch.yaml
EOF

echo "Prod overlay output:"
kubectl kustomize /root/overlays/prod/
