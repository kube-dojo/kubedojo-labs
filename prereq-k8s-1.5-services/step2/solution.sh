#!/bin/bash
CLUSTER_IP=$(kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}')
for i in $(seq 1 15); do
  if curl -fsS --connect-timeout 3 --max-time 10 "$CLUSTER_IP" > "$HOME"/curl-output.txt 2>/dev/null; then
    exit 0
  fi
  sleep 2
done
exit 1
