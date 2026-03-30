#!/bin/bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml
sleep 5
cat <<'EOF' | kubectl apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: lab-gateway-class
spec:
  controllerName: example.com/gateway-controller
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: lab-gateway
  namespace: practice
spec:
  gatewayClassName: lab-gateway-class
  listeners:
  - name: http
    protocol: HTTP
    port: 80
EOF
kubectl get gatewayclass
kubectl get gateway -n practice
