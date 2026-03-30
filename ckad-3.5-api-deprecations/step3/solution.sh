#!/bin/bash
kubectl get deployment legacy-app -n api-lab -o yaml > /root/migrated-manifest.yaml
kubectl apply -f /root/migrated-manifest.yaml --dry-run=server 2>/dev/null
echo "apps/v1" > /root/final-api-version.txt
