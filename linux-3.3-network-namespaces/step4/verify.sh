#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/isolation-test.txt exists and has content
if [ ! -f $USER_HOME/isolation-test.txt ]; then
  echo "FAIL: $USER_HOME/isolation-test.txt does not exist"
  exit 1
fi

if [ -s $USER_HOME/isolation-test.txt ]; then
  echo "PASS: $USER_HOME/isolation-test.txt exists and has content (isolation test performed)"
  exit 0
else
  echo "FAIL: $USER_HOME/isolation-test.txt is empty"
  exit 1
fi
