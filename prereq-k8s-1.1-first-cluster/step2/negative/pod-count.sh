#!/bin/bash
set -euo pipefail
actual=$(kubectl get pods -n kube-system --no-headers | wc -l)
printf '%s\n' "$((actual + 1))" > "$HOME/cp-pod-count.txt"
