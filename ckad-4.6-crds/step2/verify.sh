#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get backupjob daily-backup -n crd-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: BackupJob daily-backup not found"
  exit 1
fi
kubectl get backupjob weekly-backup -n crd-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: BackupJob weekly-backup not found"
  exit 1
fi
if [ ! -f $USER_HOME/backupjobs-list.txt ]; then
  echo "FAIL: $USER_HOME/backupjobs-list.txt not found"
  exit 1
fi
echo "PASS"
exit 0
