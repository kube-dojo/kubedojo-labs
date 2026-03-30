#!/bin/bash
cat <<'YAML' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: adapter-pod
  namespace: multi-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "while true; do echo \"$(date +%s) cpu_usage $(( RANDOM % 100 ))\" >> /metrics/raw.log; sleep 5; done"]
    volumeMounts:
    - name: metrics
      mountPath: /metrics
  - name: transformer
    image: busybox:1.36
    command: ["sh", "-c", "tail -f /metrics/raw.log | while read line; do echo \"METRIC: $line\" >> /metrics/formatted.log; done"]
    volumeMounts:
    - name: metrics
      mountPath: /metrics
  volumes:
  - name: metrics
    emptyDir: {}
YAML
kubectl wait --for=condition=Ready pod/adapter-pod -n multi-lab --timeout=60s
