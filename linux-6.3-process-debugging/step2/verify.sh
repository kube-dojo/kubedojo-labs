#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/open-files.txt ]; then
  echo "FAIL: $USER_HOME/open-files.txt not found"
  exit 1
fi

if [ -s $USER_HOME/open-files.txt ]; then
  echo "PASS: open-files.txt has content"
  exit 0
else
  echo "FAIL: open-files.txt is empty"
  exit 1
fi
