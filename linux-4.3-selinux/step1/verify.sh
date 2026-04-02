#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify SELinux status file

if [ ! -f $USER_HOME/selinux-status.txt ]; then
  echo "FAIL: $USER_HOME/selinux-status.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/selinux-status.txt ]; then
  echo "FAIL: $USER_HOME/selinux-status.txt is empty"
  exit 1
fi

echo "PASS: SELinux status report saved"
exit 0
