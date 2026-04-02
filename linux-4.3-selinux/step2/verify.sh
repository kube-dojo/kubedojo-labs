#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify file context documentation

if [ ! -f $USER_HOME/selinux-lab/context-report.txt ]; then
  echo "FAIL: $USER_HOME/selinux-lab/context-report.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/selinux-lab/context-report.txt ]; then
  echo "FAIL: $USER_HOME/selinux-lab/context-report.txt is empty"
  exit 1
fi

echo "PASS: File context report documented"
exit 0
