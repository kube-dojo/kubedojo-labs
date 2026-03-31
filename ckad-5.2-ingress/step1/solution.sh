#!/bin/bash
# Wait for ingress controller to be ready
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/component=controller -n ingress-nginx --timeout=120s 2>/dev/null || true
# Wait for admission webhook
for i in $(seq 1 30); do
  kubectl get validatingwebhookconfigurations ingress-nginx-admission 2>/dev/null && break
  sleep 2
done
sleep 5  # extra buffer for webhook readiness

cat <<YAML | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: basic-ingress
  namespace: ingress-lab
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
YAML
echo "nginx" > /root/ingress-class.txt
