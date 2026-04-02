#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify AppArmor logs file

if [ ! -f $USER_HOME/apparmor-logs.txt ]; then
  echo "FAIL: $USER_HOME/apparmor-logs.txt does not exist"
  exit 1
fi

if [ -s $USER_HOME/apparmor-logs.txt ]; then
  echo "PASS: AppArmor logs file exists with content"
  exit 0
else
  echo "FAIL: $USER_HOME/apparmor-logs.txt is empty"
  exit 1
fi
