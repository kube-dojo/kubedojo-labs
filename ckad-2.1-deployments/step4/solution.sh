#!/bin/bash
kubectl set image deployment/broken-deploy nginx=nginx:1.25 -n deploy-lab
kubectl rollout status deployment/broken-deploy -n deploy-lab --timeout=90s
kubectl get deployment broken-deploy -n deploy-lab -o jsonpath='{.status.availableReplicas}' > /root/fixed-replicas.txt
