#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify both files exist with content
if [ ! -f $USER_HOME/memory.txt ]; then
  echo "$USER_HOME/memory.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/memory.txt ]; then
  echo "$USER_HOME/memory.txt is empty"
  exit 1
fi

if [ ! -f $USER_HOME/disk.txt ]; then
  echo "$USER_HOME/disk.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/disk.txt ]; then
  echo "$USER_HOME/disk.txt is empty"
  exit 1
fi

echo "Resource info captured. Good work!"
exit 0
