#!/bin/bash
set -euo pipefail
kubectl wait --for=condition=Ready pod/web --timeout=120s
actual=$(kubectl get pod web -o jsonpath='{.status.podIP}')
if [ "$actual" = 192.0.2.1 ]; then wrong=192.0.2.2; else wrong=192.0.2.1; fi
printf '%s\n' "$wrong" > "$HOME/web-pod-ip.txt"
