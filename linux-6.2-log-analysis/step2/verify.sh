#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/5xx-count.txt ]; then
  echo "FAIL: $USER_HOME/5xx-count.txt not found"
  exit 1
fi

COUNT=$(cat $USER_HOME/5xx-count.txt | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]] && [ "$COUNT" -gt 0 ]; then
  echo "PASS: Found $COUNT 5xx errors"
  exit 0
else
  echo "FAIL: Expected a positive number, got '$COUNT'"
  exit 1
fi
