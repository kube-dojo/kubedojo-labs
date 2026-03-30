#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: external-api
  namespace: practice
spec:
  type: ExternalName
  externalName: api.example.com
---
apiVersion: v1
kind: Service
metadata:
  name: external-db
  namespace: practice
spec:
  type: ExternalName
  externalName: db.example.com
EOF
kubectl get svc -n practice
