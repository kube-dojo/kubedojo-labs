#!/bin/bash
kubectl set image deployment/webapp nginx=nginx:1.25 -n deploy-lab
kubectl annotate deployment webapp -n deploy-lab kubernetes.io/change-cause="Update to nginx 1.25"
kubectl rollout status deployment/webapp -n deploy-lab --timeout=60s > /root/rollout-status.txt
