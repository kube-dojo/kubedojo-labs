#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/umask-test.txt exists with permissions 640
if [ ! -f $USER_HOME/umask-test.txt ]; then
  echo "$USER_HOME/umask-test.txt does not exist"
  exit 1
fi

perms=$(stat -c '%a' $USER_HOME/umask-test.txt)
if [ "$perms" = "640" ]; then
  echo "Permissions are 640. Perfect!"
  exit 0
else
  echo "Expected permissions 640, got $perms"
  exit 1
fi
