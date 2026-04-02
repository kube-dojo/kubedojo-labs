#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/total-lines.txt exists and contains a number
if [ ! -f $USER_HOME/total-lines.txt ]; then
  echo "$USER_HOME/total-lines.txt does not exist"
  exit 1
fi

count=$(cat $USER_HOME/total-lines.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Total lines: $count. Well done!"
  exit 0
else
  echo "File should contain a number, got: '$count'"
  exit 1
fi
