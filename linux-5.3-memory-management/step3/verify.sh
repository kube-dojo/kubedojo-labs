#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/oom-candidate.txt ]; then
  echo "FAIL: $USER_HOME/oom-candidate.txt not found"
  exit 1
fi

if grep -q "PID:" $USER_HOME/oom-candidate.txt && grep -q "Score:" $USER_HOME/oom-candidate.txt; then
  echo "PASS: File contains PID and Score"
  exit 0
else
  echo "FAIL: File should contain PID and Score entries"
  exit 1
fi
