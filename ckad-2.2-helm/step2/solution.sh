#!/bin/bash
cat > "$HOME"/custom-values.yaml << 'YAML'
replicaCount: 3
service:
  type: ClusterIP
YAML
helm install custom-app bitnami/nginx -n helm-lab -f "$HOME"/custom-values.yaml
helm get values custom-app -n helm-lab > "$HOME"/custom-app-values.txt
