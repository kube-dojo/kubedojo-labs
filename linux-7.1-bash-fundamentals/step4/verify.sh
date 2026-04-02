#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/safe-script.sh ]; then
  echo "FAIL: $USER_HOME/safe-script.sh not found"
  exit 1
fi

if ! grep -q "set -e" $USER_HOME/safe-script.sh; then
  echo "FAIL: Script should contain 'set -e'"
  exit 1
fi

if ! grep -q "trap" $USER_HOME/safe-script.sh; then
  echo "FAIL: Script should contain a 'trap' statement"
  exit 1
fi

echo "PASS: Script contains set -e and trap"
exit 0
