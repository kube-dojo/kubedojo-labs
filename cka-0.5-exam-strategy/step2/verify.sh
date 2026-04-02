#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/task-order.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(tr -d '[:space:]' < "$FILE" | tr '[:lower:]' '[:upper:]')

if [ "$CONTENT" = "BDEAC" ]; then
  echo "PASS: Optimal task order verified!"
  exit 0
else
  echo "FAIL: Incorrect order. Found: $CONTENT, Expected: BDEAC"
  exit 1
fi