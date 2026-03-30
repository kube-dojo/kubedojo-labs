#!/bin/bash
if [ ! -f /root/nginx-deploy.yaml ]; then
  echo "FAIL: /root/nginx-deploy.yaml does not exist"
  exit 1
fi

if grep -q "replicas: 2" /root/nginx-deploy.yaml && grep -q "nginx" /root/nginx-deploy.yaml; then
  echo "PASS: YAML contains replicas: 2 and nginx"
  exit 0
else
  echo "FAIL: YAML should contain 'replicas: 2' and 'nginx'"
  exit 1
fi
