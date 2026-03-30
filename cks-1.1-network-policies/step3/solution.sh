#!/bin/bash
DNS_IP=$(kubectl get svc kube-dns -n kube-system -o jsonpath='{.spec.clusterIP}')
echo "$DNS_IP" > /root/dns-ip.txt

cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-egress-restrict
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: db
    ports:
    - protocol: TCP
      port: 80
  - to:
    - ipBlock:
        cidr: ${DNS_IP}/32
    ports:
    - protocol: UDP
      port: 53
YAML
