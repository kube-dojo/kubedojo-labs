#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
RESOURCE=$(kubectl get backup daily-backup -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: Backup resource 'daily-backup' not found"
  exit 1
fi

# Verify spec fields
SCHEDULE=$(echo "$RESOURCE" | jq -r '.spec.schedule')
TARGET=$(echo "$RESOURCE" | jq -r '.spec.target')
RETENTION=$(echo "$RESOURCE" | jq -r '.spec.retention')

if [ "$SCHEDULE" = "0 2 * * *" ] && [ "$TARGET" = "etcd" ] && [ "$RETENTION" = "7" ]; then
  echo "PASS: Backup resource 'daily-backup' verified with correct spec"
  exit 0
else
  echo "FAIL: Backup resource spec fields are incorrect"
  exit 1
fi