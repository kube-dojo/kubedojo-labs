#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$HOME"/tls.key -out "$HOME"/tls.crt \
  -subj "/CN=secure.example.com/O=CKS Lab"
kubectl create secret tls tls-secret --cert="$HOME"/tls.crt --key="$HOME"/tls.key -n ingress-lab
kubectl get secret tls-secret -n ingress-lab -o jsonpath='{.type}' > "$HOME"/secret-type.txt
