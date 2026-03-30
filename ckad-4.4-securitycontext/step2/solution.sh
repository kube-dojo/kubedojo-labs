#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: cap-pod
  namespace: security-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    securityContext:
      capabilities:
        drop: ["ALL"]
        add: ["NET_BIND_SERVICE"]
      readOnlyRootFilesystem: true
    volumeMounts:
    - name: tmp
      mountPath: /tmp
  volumes:
  - name: tmp
    emptyDir: {}
YAML
kubectl wait --for=condition=Ready pod/cap-pod -n security-lab --timeout=60s
kubectl get pod cap-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.readOnlyRootFilesystem}' > /root/readonly-fs.txt
