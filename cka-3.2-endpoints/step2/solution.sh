#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: external-database
  namespace: practice
spec:
  ports:
  - port: 5432
    targetPort: 5432
---
apiVersion: v1
kind: Endpoints
metadata:
  name: external-database
  namespace: practice
subsets:
  - addresses:
    - ip: 10.0.0.100
    ports:
    - port: 5432
EOF
kubectl get endpoints external-database -n practice
