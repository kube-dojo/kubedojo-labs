#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: temp-storage
  namespace: volumes-lab
spec:
  containers:
  - name: writer
    image: busybox:1.36
    command: ["sh", "-c", "echo hello > /cache/greeting.txt; sleep 3600"]
    volumeMounts:
    - name: cache-vol
      mountPath: /cache
  volumes:
  - name: cache-vol
    emptyDir: {}
---
apiVersion: v1
kind: Pod
metadata:
  name: host-storage
  namespace: volumes-lab
spec:
  containers:
  - name: reader
    image: busybox:1.36
    command: ["sh", "-c", "cat /host-data/test.txt || sleep 3600"]
    volumeMounts:
    - name: host-vol
      mountPath: /host-data
  volumes:
  - name: host-vol
    hostPath:
      path: /data/hostpath-demo
      type: DirectoryOrCreate
YAML
kubectl wait --for=condition=Ready pod/temp-storage -n volumes-lab --timeout=120s 2>/dev/null || true
kubectl wait --for=condition=Ready pod/host-storage -n volumes-lab --timeout=120s 2>/dev/null || true
echo "hostpath-works" > /data/hostpath-demo/test.txt
