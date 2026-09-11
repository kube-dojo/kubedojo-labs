#!/bin/bash
kubectl get pods -n kube-system -l tier=control-plane -o wide > "$HOME"/cp-health.txt
echo "---" >> "$HOME"/cp-health.txt
curl -sk https://localhost:6443/healthz >> "$HOME"/cp-health.txt
echo "" >> "$HOME"/cp-health.txt
echo "=== API Health ===" >> "$HOME"/cp-health.txt
for endpoint in healthz livez readyz; do
  echo "$endpoint: $(curl -sk https://localhost:6443/$endpoint)" >> "$HOME"/cp-health.txt
done
cat "$HOME"/cp-health.txt
