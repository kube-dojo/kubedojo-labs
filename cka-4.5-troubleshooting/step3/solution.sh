#!/bin/bash
kubectl delete pod broken-mount-pod -n practice --force --grace-period=0 2>/dev/null
sleep 2
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: broken-mount-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: nginx:1.25
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: correct-pvc
EOF
kubectl wait --for=condition=Ready pod/broken-mount-pod -n practice --timeout=60s
