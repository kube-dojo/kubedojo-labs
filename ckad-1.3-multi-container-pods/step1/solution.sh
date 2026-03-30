#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: web-init
  namespace: multi-lab
spec:
  initContainers:
  - name: init-config
    image: busybox:1.36
    command: ["sh", "-c", "echo Initialized > /work-dir/status.txt"]
    volumeMounts:
    - name: shared-data
      mountPath: /work-dir
  containers:
  - name: web
    image: nginx:1.25
    volumeMounts:
    - name: shared-data
      mountPath: /usr/share/nginx/html
  volumes:
  - name: shared-data
    emptyDir: {}
YAML
kubectl wait --for=condition=Ready pod/web-init -n multi-lab --timeout=60s
