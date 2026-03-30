#!/bin/bash
kubectl delete svc sts-svc -n practice --ignore-not-found
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: sts-svc
  namespace: practice
spec:
  clusterIP: None
  selector:
    app: web-sts
  ports:
  - port: 80
    targetPort: 80
EOF
