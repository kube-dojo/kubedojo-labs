#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: parallel-job
  namespace: practice
spec:
  completions: 5
  parallelism: 2
  template:
    spec:
      containers:
      - name: worker
        image: busybox:1.36
        command: ["sh", "-c", "echo Processing item; sleep 5; echo Done"]
      restartPolicy: Never
EOF
kubectl wait --for=condition=Complete job/parallel-job -n practice --timeout=120s
