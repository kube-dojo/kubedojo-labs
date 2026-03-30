#!/bin/bash
kubectl get deployment webapp 2>/dev/null || kubectl create deployment webapp --image=nginx:1.25 --replicas=3
kubectl rollout status deployment/webapp --timeout=120s
