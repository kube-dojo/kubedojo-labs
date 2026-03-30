#!/bin/bash
kubectl create deployment nginx --image=nginx --replicas=2 --dry-run=client -o yaml > /root/nginx-deploy.yaml
echo "Generated /root/nginx-deploy.yaml:"
cat /root/nginx-deploy.yaml
