#!/bin/bash
cat > "$HOME"/secure-ingress.yaml << 'YAML'
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-ingress
  namespace: ingress-lab
spec:
  tls:
  - hosts:
    - secure.example.com
    secretName: tls-secret
  rules:
  - host: secure.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-app
            port:
              number: 80
YAML
kubectl apply -f "$HOME"/secure-ingress.yaml
