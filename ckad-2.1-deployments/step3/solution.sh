#!/bin/bash
kubectl rollout history deployment/webapp -n deploy-lab
kubectl rollout undo deployment/webapp -n deploy-lab
kubectl rollout status deployment/webapp -n deploy-lab --timeout=60s
kubectl get deployment webapp -n deploy-lab -o jsonpath='{.spec.template.spec.containers[0].image}' > /root/rollback-image.txt
