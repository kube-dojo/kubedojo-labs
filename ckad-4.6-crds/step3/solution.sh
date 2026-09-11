#!/bin/bash
kubectl get backupjob daily-backup -n crd-lab -o yaml > "$HOME"/daily-backup.yaml
kubectl get backupjob daily-backup -n crd-lab -o jsonpath='{.spec.target}' > "$HOME"/backup-target.txt
kubectl delete backupjob weekly-backup -n crd-lab
kubectl get bj -n crd-lab --no-headers | wc -l | tr -d ' ' > "$HOME"/bj-count.txt
