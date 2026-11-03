#!/bin/bash
set -euo pipefail
kubectl run nginx-pod --image=nginx:1.26 --dry-run=client -o yaml > "$HOME/pod-spec.yaml"
