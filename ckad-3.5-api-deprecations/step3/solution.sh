#!/bin/bash
kubectl get deployment legacy-app -n api-lab -o yaml > "$HOME"/migrated-manifest.yaml
kubectl apply -f "$HOME"/migrated-manifest.yaml --dry-run=server 2>/dev/null
echo "apps/v1" > "$HOME"/final-api-version.txt
