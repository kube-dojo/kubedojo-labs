#!/bin/bash
cat <<YAML | tee /root/path-ingress.yaml | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: path-ingress
  namespace: ingress-lab
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /frontend
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
      - path: /backend
        pathType: Prefix
        backend:
          service:
            name: backend
            port:
              number: 80
YAML
echo "2" > /root/path-count.txt
