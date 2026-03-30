#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: vol-pod
  namespace: cm-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    volumeMounts:
    - name: config-vol
      mountPath: /etc/config
  volumes:
  - name: config-vol
    configMap:
      name: file-config
YAML
kubectl wait --for=condition=Ready pod/vol-pod -n cm-lab --timeout=60s
kubectl exec vol-pod -n cm-lab -- cat /etc/config/app.properties > /root/mounted-config.txt
