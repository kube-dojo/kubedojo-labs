#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/tcp-connections.txt exists and has content
if [ ! -f $USER_HOME/tcp-connections.txt ]; then
  echo "FAIL: $USER_HOME/tcp-connections.txt does not exist"
  exit 1
fi

if [ -s $USER_HOME/tcp-connections.txt ]; then
  echo "PASS: File has content"
  exit 0
else
  echo "FAIL: $USER_HOME/tcp-connections.txt is empty"
  exit 1
fi
