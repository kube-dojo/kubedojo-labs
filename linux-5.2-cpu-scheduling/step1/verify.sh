#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/sched-policy.txt ]; then
  echo "FAIL: $USER_HOME/sched-policy.txt not found"
  exit 1
fi

if [ -s $USER_HOME/sched-policy.txt ]; then
  echo "PASS: sched-policy.txt has content"
  exit 0
else
  echo "FAIL: sched-policy.txt is empty"
  exit 1
fi
