#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/error-count.txt ]; then
  echo "FAIL: $USER_HOME/error-count.txt not found"
  exit 1
fi

COUNT=$(cat $USER_HOME/error-count.txt | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]]; then
  echo "PASS: Error count is $COUNT (0 is valid in clean environments)"
  exit 0
else
  echo "FAIL: error-count.txt should contain a number, got: $COUNT"
  exit 1
fi
