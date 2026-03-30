#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: netpol-lab
spec:
  podSelector: {}
  policyTypes:
  - Ingress
YAML
echo "default-deny-ingress" > /root/deny-policy.txt
