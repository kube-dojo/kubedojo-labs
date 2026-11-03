#!/bin/bash
set -euo pipefail
kubectl run nginx --image=nginx:1.26 --dry-run=client -o yaml > "$HOME/nginx-pod.yaml"
