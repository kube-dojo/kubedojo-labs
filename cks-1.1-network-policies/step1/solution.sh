#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: backend
spec:
  podSelector: {}
  policyTypes:
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-egress
  namespace: backend
spec:
  podSelector: {}
  policyTypes:
  - Egress
YAML
API_IP=$(kubectl get pod api -n backend -o jsonpath='{.status.podIP}')
kubectl exec web -n frontend -- timeout 3 curl -s "$API_IP" > /root/netpol-test-1.txt 2>&1 || echo "Connection blocked" > /root/netpol-test-1.txt
