#!/bin/bash
if [ ! -f /root/daily-backup.yaml ]; then
  echo "FAIL: /root/daily-backup.yaml not found"
  exit 1
fi
if [ ! -f /root/backup-target.txt ]; then
  echo "FAIL: /root/backup-target.txt not found"
  exit 1
fi
TARGET=$(cat /root/backup-target.txt | tr -d '[:space:]')
if [ "$TARGET" != "production-db" ]; then
  echo "FAIL: Target should be production-db"
  exit 1
fi
kubectl get backupjob weekly-backup -n crd-lab > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "FAIL: weekly-backup should be deleted"
  exit 1
fi
if [ ! -f /root/bj-count.txt ]; then
  echo "FAIL: /root/bj-count.txt not found"
  exit 1
fi
echo "PASS"
exit 0
