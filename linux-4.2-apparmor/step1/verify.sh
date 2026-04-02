#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify enforce count file

if [ ! -f $USER_HOME/enforce-count.txt ]; then
  echo "FAIL: $USER_HOME/enforce-count.txt does not exist"
  exit 1
fi

CONTENT=$(cat $USER_HOME/enforce-count.txt | tr -d '[:space:]')

if [[ "$CONTENT" =~ ^[0-9]+$ ]]; then
  echo "PASS: Enforce count is $CONTENT"
  exit 0
else
  echo "FAIL: $USER_HOME/enforce-count.txt does not contain a number (found: '$CONTENT')"
  exit 1
fi
