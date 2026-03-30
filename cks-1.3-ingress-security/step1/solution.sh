#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /root/tls.key -out /root/tls.crt \
  -subj "/CN=secure.example.com/O=CKS Lab"
kubectl create secret tls tls-secret --cert=/root/tls.crt --key=/root/tls.key -n ingress-lab
kubectl get secret tls-secret -n ingress-lab -o jsonpath='{.type}' > /root/secret-type.txt
