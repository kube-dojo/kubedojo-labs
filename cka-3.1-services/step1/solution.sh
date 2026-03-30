#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: backend-svc
  namespace: practice
spec:
  selector:
    app: web
    tier: backend
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
EOF
kubectl wait --for=jsonpath='{.spec.clusterIP}' svc/backend-svc -n practice --timeout=30s
