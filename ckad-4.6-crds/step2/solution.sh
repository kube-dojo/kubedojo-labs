#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: stable.example.com/v1
kind: BackupJob
metadata:
  name: daily-backup
  namespace: crd-lab
spec:
  schedule: "0 2 * * *"
  target: "production-db"
  retention: 7
---
apiVersion: stable.example.com/v1
kind: BackupJob
metadata:
  name: weekly-backup
  namespace: crd-lab
spec:
  schedule: "0 3 * * 0"
  target: "staging-db"
  retention: 30
YAML
kubectl get backupjobs -n crd-lab > /root/backupjobs-list.txt
