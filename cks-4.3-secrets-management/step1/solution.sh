#!/bin/bash
kubectl create secret generic app-secret --from-literal=password='S3cur3P@ss!' -n secrets-lab
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=test"
kubectl create secret tls tls-secret --cert=/tmp/tls.crt --key=/tmp/tls.key -n secrets-lab
kubectl create secret docker-registry registry-secret --docker-server=registry.example.com --docker-username=user --docker-password=pass --docker-email=user@example.com -n secrets-lab

ETCDCTL_API=3 etcdctl get /registry/secrets/secrets-lab/app-secret \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key | hexdump -C | head -20 > /root/etcd-secret-raw.txt 2>&1
