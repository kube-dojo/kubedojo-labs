#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/block-devices.txt ]; then
  echo "FAIL: $USER_HOME/block-devices.txt not found"
  exit 1
fi

if [ -s $USER_HOME/block-devices.txt ]; then
  echo "PASS: block-devices.txt has content"
  exit 0
else
  echo "FAIL: block-devices.txt is empty"
  exit 1
fi
