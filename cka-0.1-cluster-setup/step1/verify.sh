#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify node-count.txt exists and contains a number >= 1
if [ ! -f $USER_HOME/node-count.txt ]; then
  echo "FAIL: $USER_HOME/node-count.txt does not exist"
  exit 1
fi

COUNT=$(cat $USER_HOME/node-count.txt | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]] && [ "$COUNT" -ge 1 ]; then
  echo "PASS: Node count is $COUNT"
  exit 0
else
  echo "FAIL: $USER_HOME/node-count.txt should contain a number >= 1, got: $COUNT"
  exit 1
fi
