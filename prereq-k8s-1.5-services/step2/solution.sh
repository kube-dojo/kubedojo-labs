#!/bin/bash
CLUSTER_IP=$(kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}')
for i in $(seq 1 15); do
  if curl -s --connect-timeout 3 "$CLUSTER_IP" > /root/curl-output.txt 2>/dev/null; then
    break
  fi
  sleep 2
done
