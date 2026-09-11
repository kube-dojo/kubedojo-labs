#!/bin/bash
kubectl create deployment nginx --image=nginx --replicas=2 --dry-run=client -o yaml > "$HOME"/nginx-deploy.yaml
echo "Generated $HOME/nginx-deploy.yaml:"
cat "$HOME"/nginx-deploy.yaml
