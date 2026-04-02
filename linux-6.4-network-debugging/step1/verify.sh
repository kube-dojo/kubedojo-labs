#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/connectivity.txt ]; then
  echo "FAIL: $USER_HOME/connectivity.txt not found"
  exit 1
fi

if [ -s $USER_HOME/connectivity.txt ]; then
  echo "PASS: connectivity.txt exists and has content"
  exit 0
else
  echo "FAIL: connectivity.txt is empty"
  exit 1
fi
