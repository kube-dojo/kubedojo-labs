#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pvc-pod
  namespace: volumes-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "echo persistent-data > /data/output.txt; sleep 3600"]
    volumeMounts:
    - name: data-vol
      mountPath: /data
  volumes:
  - name: data-vol
    persistentVolumeClaim:
      claimName: pvc-data
YAML
kubectl wait --for=condition=Ready pod/pvc-pod -n volumes-lab --timeout=60s
kubectl exec pvc-pod -n volumes-lab -- cat /data/output.txt > /root/persistent-output.txt
