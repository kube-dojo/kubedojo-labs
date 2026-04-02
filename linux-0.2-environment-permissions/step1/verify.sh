#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify MY_APP and PATH updates in ~/.bashrc
if ! grep -q 'MY_APP=/opt/myapp' ~/.bashrc 2>/dev/null; then
  echo "MY_APP=/opt/myapp not found in ~/.bashrc"
  exit 1
fi

if ! grep -q '/opt/myapp/bin' ~/.bashrc 2>/dev/null; then
  echo "/opt/myapp/bin not found in PATH setting in ~/.bashrc"
  exit 1
fi

echo "Environment variables are persisted. Nice!"
exit 0
