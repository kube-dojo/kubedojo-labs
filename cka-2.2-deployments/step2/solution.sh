#!/bin/bash
# Ensure deployment exists
kubectl get deployment web-deploy -n practice 2>/dev/null || \
  kubectl create deployment web-deploy --image=nginx:1.24 --replicas=3 -n practice

kubectl rollout status deployment/web-deploy -n practice --timeout=120s
kubectl annotate deployment/web-deploy -n practice kubernetes.io/change-cause="initial deploy nginx:1.24" --overwrite

kubectl set image deployment/web-deploy nginx=nginx:1.25 -n practice
kubectl rollout status deployment/web-deploy -n practice --timeout=120s
kubectl annotate deployment/web-deploy -n practice kubernetes.io/change-cause="update to nginx:1.25" --overwrite

kubectl set image deployment/web-deploy nginx=nginx:1.26 -n practice
kubectl rollout status deployment/web-deploy -n practice --timeout=120s
kubectl annotate deployment/web-deploy -n practice kubernetes.io/change-cause="update to nginx:1.26" --overwrite
