#!/bin/bash
cat > /root/custom-values.yaml << 'YAML'
replicaCount: 3
service:
  type: ClusterIP
YAML
helm install custom-app bitnami/nginx -n helm-lab -f /root/custom-values.yaml
helm get values custom-app -n helm-lab > /root/custom-app-values.txt
