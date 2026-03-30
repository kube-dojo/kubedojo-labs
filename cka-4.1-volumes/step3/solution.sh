#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: projected-pod
  namespace: practice
  labels:
    app: projected-demo
    env: production
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    volumeMounts:
    - name: all-config
      mountPath: /etc/app-config
  volumes:
  - name: all-config
    projected:
      sources:
      - configMap:
          name: app-config
      - secret:
          name: app-secret
      - downwardAPI:
          items:
          - path: labels
            fieldRef:
              fieldPath: metadata.labels
EOF
kubectl wait --for=condition=Ready pod/projected-pod -n practice --timeout=60s
kubectl exec projected-pod -n practice -- ls /etc/app-config
