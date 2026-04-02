#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/storage-classes.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -qE "standard|local-path|hostpath|no storage classes found" "$FILE"; then
  echo "PASS: Storage classes information verified"
  exit 0
else
  echo "FAIL: File does not contain expected storage class information"
  exit 1
fi