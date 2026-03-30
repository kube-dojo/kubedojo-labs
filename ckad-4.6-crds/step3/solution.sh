#!/bin/bash
kubectl get backupjob daily-backup -n crd-lab -o yaml > /root/daily-backup.yaml
kubectl get backupjob daily-backup -n crd-lab -o jsonpath='{.spec.target}' > /root/backup-target.txt
kubectl delete backupjob weekly-backup -n crd-lab
kubectl get bj -n crd-lab --no-headers | wc -l | tr -d ' ' > /root/bj-count.txt
