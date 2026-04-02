#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/nice-process.txt ]; then
  echo "FAIL: $USER_HOME/nice-process.txt not found"
  exit 1
fi

if grep -qi "nice" $USER_HOME/nice-process.txt && grep -q "\-10" $USER_HOME/nice-process.txt; then
  echo "PASS: File contains nice value -10"
  exit 0
else
  echo "FAIL: File should contain the nice value -10"
  exit 1
fi
