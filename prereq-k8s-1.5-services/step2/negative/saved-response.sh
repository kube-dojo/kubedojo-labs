#!/bin/bash
set -euo pipefail
# The preceding step creates the Service; kube-proxy may still be converging.
# Establish reachability so only the saved-response requirement is unmet.
CLUSTER_IP=$(kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}')
curl -fsS --connect-timeout 3 --max-time 10 --retry 5 --retry-delay 2 --retry-connrefused "$CLUSTER_IP" >/dev/null
printf 'nginx welcome\n' > "$HOME/curl-output.txt"
