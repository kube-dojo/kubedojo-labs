#!/bin/bash
kubectl delete job broken-job -n jobs-lab
cat <<YAML | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: fixed-job
  namespace: jobs-lab
spec:
  backoffLimit: 2
  template:
    spec:
      containers:
      - name: worker
        image: busybox:1.36
        command: ["sh", "-c", "echo Success; exit 0"]
      restartPolicy: Never
YAML
kubectl wait --for=condition=complete job/fixed-job -n jobs-lab --timeout=60s
