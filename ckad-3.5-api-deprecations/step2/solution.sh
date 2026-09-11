#!/bin/bash
kubectl apply -f "$HOME"/old-manifest.yaml
kubectl explain deployment --api-version=apps/v1 2>/dev/null | head -10 > "$HOME"/explain-output.txt
