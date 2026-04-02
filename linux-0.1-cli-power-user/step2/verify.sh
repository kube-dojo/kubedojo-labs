#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/conf-count.txt exists and contains a number > 0
if [ ! -f $USER_HOME/conf-count.txt ]; then
  echo "$USER_HOME/conf-count.txt does not exist"
  exit 1
fi

count=$(cat $USER_HOME/conf-count.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]] && [ "$count" -gt 0 ]; then
  echo "Found $count .conf files. Well done!"
  exit 0
else
  echo "File should contain a number greater than 0, got: '$count'"
  exit 1
fi
