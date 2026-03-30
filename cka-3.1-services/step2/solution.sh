#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: frontend-nodeport
  namespace: practice
spec:
  type: NodePort
  selector:
    app: web
    tier: frontend
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
EOF
sleep 2
NODE_IP=$(kubectl get node -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
curl -s http://$NODE_IP:30080 | head -5
