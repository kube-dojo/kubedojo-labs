#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: host-ingress
  namespace: ingress-lab
spec:
  ingressClassName: nginx
  rules:
  - host: frontend.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
  - host: backend.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: backend
            port:
              number: 80
YAML
kubectl get ingress host-ingress -n ingress-lab -o jsonpath='{.spec.rules[*].host}' > /root/ingress-hosts.txt
