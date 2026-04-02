#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/sed-output.txt ]; then
  echo "FAIL: $USER_HOME/sed-output.txt not found"
  exit 1
fi

if grep -q "DATABASE_HOST\|DATABASE_PORT\|LOG_LEVEL" $USER_HOME/sed-output.txt; then
  echo "PASS: sed-output.txt contains uppercase keys"
  exit 0
else
  echo "FAIL: Keys should be uppercase (e.g., DATABASE_HOST=localhost)"
  exit 1
fi
