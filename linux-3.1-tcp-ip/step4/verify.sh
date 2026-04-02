#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/port22-service.txt contains "ssh"
if [ ! -f $USER_HOME/port22-service.txt ]; then
  echo "FAIL: $USER_HOME/port22-service.txt does not exist"
  exit 1
fi

if grep -qi "ssh" $USER_HOME/port22-service.txt; then
  echo "PASS: File contains 'ssh'"
  exit 0
else
  echo "FAIL: $USER_HOME/port22-service.txt does not contain 'ssh'"
  exit 1
fi
