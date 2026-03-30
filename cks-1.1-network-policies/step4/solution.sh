#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-policy
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: db
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: api
    ports:
    - protocol: TCP
      port: 80
YAML
kubectl get networkpolicy -n backend -o wide > /root/netpol-summary.txt
cat > /root/traffic-matrix.txt << 'MATRIX'
frontend/web -> backend/api : TCP 80
backend/api -> backend/db : TCP 80
backend/api -> kube-system/kube-dns : UDP 53
MATRIX
