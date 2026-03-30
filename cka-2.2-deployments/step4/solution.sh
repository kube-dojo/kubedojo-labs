#!/bin/bash
kubectl rollout pause deployment/web-deploy -n practice
kubectl set image deployment/web-deploy nginx=nginx:1.27 -n practice
kubectl set resources deployment/web-deploy -c nginx --limits=cpu=200m,memory=128Mi -n practice
kubectl rollout resume deployment/web-deploy -n practice
kubectl rollout status deployment/web-deploy -n practice --timeout=120s
