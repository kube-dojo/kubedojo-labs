#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify both files exist with content
if [ ! -f $USER_HOME/kernel-version.txt ]; then
  echo "$USER_HOME/kernel-version.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/kernel-version.txt ]; then
  echo "$USER_HOME/kernel-version.txt is empty"
  exit 1
fi

if [ ! -f $USER_HOME/module-count.txt ]; then
  echo "$USER_HOME/module-count.txt does not exist"
  exit 1
fi

count=$(cat $USER_HOME/module-count.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Kernel: $(cat $USER_HOME/kernel-version.txt | tr -d '[:space:]'), Modules: $count"
  exit 0
else
  echo "module-count.txt should contain a number, got: '$count'"
  exit 1
fi
