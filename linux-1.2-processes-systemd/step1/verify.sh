#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/process-states.txt exists and contains S (sleeping)
if [ ! -f $USER_HOME/process-states.txt ]; then
  echo "$USER_HOME/process-states.txt does not exist"
  exit 1
fi

if grep -q "S" $USER_HOME/process-states.txt; then
  echo "Process states found: $(cat $USER_HOME/process-states.txt | tr '\n' ' ')"
  exit 0
else
  echo "Expected to find state 'S' (sleeping) — most systems have sleeping processes"
  exit 1
fi
