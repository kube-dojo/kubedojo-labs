#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/rotate-backups.sh ]; then
  echo "FAIL: $USER_HOME/rotate-backups.sh not found"
  exit 1
fi

if [ ! -x $USER_HOME/rotate-backups.sh ]; then
  echo "FAIL: $USER_HOME/rotate-backups.sh is not executable"
  exit 1
fi

echo "PASS: rotate-backups.sh exists and is executable"
exit 0
