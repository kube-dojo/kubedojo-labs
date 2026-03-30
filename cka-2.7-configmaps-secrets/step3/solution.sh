#!/bin/bash
kubectl create secret generic db-creds \
  --from-literal=username=admin \
  --from-literal=password='s3cur3P@ss' \
  -n practice 2>/dev/null || true

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secrets
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: db-creds
EOF
kubectl wait --for=condition=Ready pod/secret-pod -n practice --timeout=60s
