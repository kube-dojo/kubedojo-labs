#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/ltrace-output.txt ]; then
  echo "FAIL: $USER_HOME/ltrace-output.txt not found"
  exit 1
fi

if [ -s $USER_HOME/ltrace-output.txt ]; then
  echo "PASS: ltrace-output.txt has content"
  exit 0
else
  echo "FAIL: ltrace-output.txt is empty"
  exit 1
fi
