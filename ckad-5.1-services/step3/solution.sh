#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: web-headless
  namespace: svc-lab
spec:
  clusterIP: None
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
YAML
echo "None" > /root/headless-ip.txt
