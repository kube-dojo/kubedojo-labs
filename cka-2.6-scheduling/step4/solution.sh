#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: spread-deploy
  namespace: practice
spec:
  replicas: 3
  selector:
    matchLabels:
      app: spread-app
  template:
    metadata:
      labels:
        app: spread-app
    spec:
      topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: kubernetes.io/hostname
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: spread-app
      containers:
      - name: nginx
        image: nginx:1.25
EOF
kubectl rollout status deployment/spread-deploy -n practice --timeout=120s 2>/dev/null || true
