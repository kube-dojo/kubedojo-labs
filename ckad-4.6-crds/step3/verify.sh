#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/daily-backup.yaml ]; then
  echo "FAIL: $USER_HOME/daily-backup.yaml not found"
  exit 1
fi
if [ ! -f $USER_HOME/backup-target.txt ]; then
  echo "FAIL: $USER_HOME/backup-target.txt not found"
  exit 1
fi
TARGET=$(cat $USER_HOME/backup-target.txt | tr -d '[:space:]')
if [ "$TARGET" != "production-db" ]; then
  echo "FAIL: Target should be production-db"
  exit 1
fi
kubectl get backupjob weekly-backup -n crd-lab > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "FAIL: weekly-backup should be deleted"
  exit 1
fi
if [ ! -f $USER_HOME/bj-count.txt ]; then
  echo "FAIL: $USER_HOME/bj-count.txt not found"
  exit 1
fi
echo "PASS"
exit 0
