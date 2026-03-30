#!/bin/bash
kubectl create deployment pinned-app --image=httpd:2.4.58 --replicas=2 -n images-lab
kubectl rollout status deployment/pinned-app -n images-lab --timeout=60s
kubectl set image deployment/pinned-app httpd=httpd:2.4.59 -n images-lab
kubectl rollout status deployment/pinned-app -n images-lab --timeout=60s
kubectl rollout history deployment/pinned-app -n images-lab > /root/rollout-history.txt
