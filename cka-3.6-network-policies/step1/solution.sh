#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-allow-frontend
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: frontend
      namespaceSelector:
        matchLabels:
          purpose: frontend
    ports:
    - protocol: TCP
      port: 80
EOF
kubectl get networkpolicy -n backend
