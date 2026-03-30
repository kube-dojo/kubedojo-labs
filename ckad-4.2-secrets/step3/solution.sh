#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: secret-vol-pod
  namespace: secrets-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    volumeMounts:
    - name: secret-vol
      mountPath: /etc/secrets
      readOnly: true
  volumes:
  - name: secret-vol
    secret:
      secretName: db-creds
YAML
kubectl wait --for=condition=Ready pod/secret-vol-pod -n secrets-lab --timeout=60s
kubectl exec secret-vol-pod -n secrets-lab -- cat /etc/secrets/username > /root/mounted-username.txt
