#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/cache-test.txt ]; then
  echo "FAIL: $USER_HOME/cache-test.txt not found"
  exit 1
fi

if [ -s $USER_HOME/cache-test.txt ]; then
  echo "PASS: cache-test.txt exists and has content"
  exit 0
else
  echo "FAIL: cache-test.txt is empty"
  exit 1
fi
