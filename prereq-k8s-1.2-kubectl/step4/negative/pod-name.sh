#!/bin/bash
set -euo pipefail
kubectl run wrong-name --image=nginx:1.25 --dry-run=client -o yaml > "$HOME/nginx-pod.yaml"
