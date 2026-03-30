#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: parallel-job
  namespace: jobs-lab
spec:
  completions: 4
  parallelism: 2
  template:
    spec:
      containers:
      - name: worker
        image: busybox:1.36
        command: ["sh", "-c", "echo Processing item; sleep 5; echo Done"]
      restartPolicy: Never
YAML
kubectl wait --for=condition=complete job/parallel-job -n jobs-lab --timeout=120s
kubectl get job parallel-job -n jobs-lab -o jsonpath='{.status.succeeded}' > /root/parallel-count.txt
