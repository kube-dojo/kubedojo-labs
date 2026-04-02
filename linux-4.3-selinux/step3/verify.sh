#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify SELinux booleans file

if [ ! -f $USER_HOME/sebooleans.txt ]; then
  echo "FAIL: $USER_HOME/sebooleans.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/sebooleans.txt ]; then
  echo "FAIL: $USER_HOME/sebooleans.txt is empty"
  exit 1
fi

echo "PASS: SELinux booleans documented"
exit 0
