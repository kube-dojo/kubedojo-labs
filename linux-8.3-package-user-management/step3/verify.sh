#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/maintenance.txt ]; then
  echo "FAIL: $USER_HOME/maintenance.txt not found"
  exit 1
fi

if [ -s $USER_HOME/maintenance.txt ]; then
  echo "PASS: maintenance.txt has content"
  exit 0
else
  echo "FAIL: maintenance.txt is empty"
  exit 1
fi
