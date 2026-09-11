#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$HOME"/tls.key -out "$HOME"/tls.crt \
  -subj "/CN=secure.example.com/O=kubedojo"
kubectl create secret tls tls-secret --cert="$HOME"/tls.crt --key="$HOME"/tls.key -n practice
cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-ingress
  namespace: practice
spec:
  ingressClassName: nginx
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
            name: app-v1
            port:
              number: 80
EOF
sleep 3
kubectl get ingress tls-ingress -n practice
