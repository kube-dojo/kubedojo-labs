#!/bin/bash
kubectl label namespace frontend name=frontend --overwrite
cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-api
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name: frontend
      podSelector:
        matchLabels:
          app: web
    ports:
    - protocol: TCP
      port: 80
YAML
API_IP=$(kubectl get pod api -n backend -o jsonpath='{.status.podIP}')
kubectl exec web -n frontend -- curl -s -o /dev/null -w '%{http_code}' "http://$API_IP" > /root/netpol-test-2.txt 2>/dev/null || echo "blocked" > /root/netpol-test-2.txt
