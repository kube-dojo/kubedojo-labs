#!/bin/bash
kubectl get pods -n kube-system -l tier=control-plane -o wide > /root/cp-health.txt
echo "---" >> /root/cp-health.txt
curl -sk https://localhost:6443/healthz >> /root/cp-health.txt
echo "" >> /root/cp-health.txt
echo "=== API Health ===" >> /root/cp-health.txt
for endpoint in healthz livez readyz; do
  echo "$endpoint: $(curl -sk https://localhost:6443/$endpoint)" >> /root/cp-health.txt
done
cat /root/cp-health.txt
