#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/recent-logs.txt ]; then
  echo "FAIL: $USER_HOME/recent-logs.txt not found"
  exit 1
fi

if [ -s $USER_HOME/recent-logs.txt ]; then
  echo "PASS: recent-logs.txt exists and has content"
  exit 0
else
  echo "FAIL: recent-logs.txt is empty"
  exit 1
fi
