#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify seccomp status file

if [ ! -f $USER_HOME/seccomp-status.txt ]; then
  echo "FAIL: $USER_HOME/seccomp-status.txt does not exist"
  exit 1
fi

if grep -qi "seccomp" $USER_HOME/seccomp-status.txt; then
  echo "PASS: seccomp status documented"
  exit 0
else
  echo "FAIL: $USER_HOME/seccomp-status.txt does not contain 'Seccomp' information"
  exit 1
fi
