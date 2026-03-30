#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: batch/v1
kind: CronJob
metadata:
  name: reporter
  namespace: jobs-lab
spec:
  schedule: "*/1 * * * *"
  successfulJobsHistoryLimit: 3
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: reporter
            image: busybox:1.36
            command: ["sh", "-c", "echo Report generated at $(date)"]
          restartPolicy: Never
YAML
kubectl get cronjob reporter -n jobs-lab -o jsonpath='{.spec.schedule}' > /root/cron-schedule.txt
kubectl create job reporter-manual --from=cronjob/reporter -n jobs-lab
kubectl wait --for=condition=complete job/reporter-manual -n jobs-lab --timeout=60s
