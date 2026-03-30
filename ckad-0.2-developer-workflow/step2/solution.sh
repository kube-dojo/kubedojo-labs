#!/bin/bash
kubectl create deployment backend --image=redis:7 --replicas=1 -n dev-workflow
kubectl rollout status deployment/backend -n dev-workflow --timeout=60s
kubectl scale deployment backend --replicas=3 -n dev-workflow
kubectl set image deployment/backend redis=redis:7.2 -n dev-workflow
kubectl rollout status deployment/backend -n dev-workflow --timeout=60s
kubectl get deployment backend -n dev-workflow -o jsonpath='{.spec.template.spec.containers[0].image}' > /root/backend-image.txt
