#!/bin/bash
kubectl create deployment webapp --image=nginx:1.24 --replicas=2 -n deploy-lab
kubectl rollout status deployment/webapp -n deploy-lab --timeout=60s
kubectl scale deployment webapp --replicas=5 -n deploy-lab
kubectl rollout status deployment/webapp -n deploy-lab --timeout=60s
kubectl get deployment webapp -n deploy-lab -o jsonpath='{.status.readyReplicas}' > /root/ready-replicas.txt
