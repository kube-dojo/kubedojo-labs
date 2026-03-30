#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: web-lb
  namespace: practice
spec:
  type: LoadBalancer
  selector:
    app: web
    tier: frontend
  ports:
  - port: 80
    targetPort: 80
EOF
sleep 3
kubectl patch svc web-lb -n practice -p '{"spec":{"type":"NodePort"}}'
sleep 2
kubectl get svc web-lb -n practice
