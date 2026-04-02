#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify www-data has read ACL on $USER_HOME/shared.txt
if [ ! -f $USER_HOME/shared.txt ]; then
  echo "$USER_HOME/shared.txt does not exist"
  exit 1
fi

if getfacl $USER_HOME/shared.txt 2>/dev/null | grep -q "user:www-data:r"; then
  echo "ACL for www-data is set correctly!"
  exit 0
else
  echo "Expected ACL entry user:www-data:r-- not found"
  exit 1
fi
