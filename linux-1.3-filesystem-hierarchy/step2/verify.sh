#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/large-files-count.txt contains a number
if [ ! -f $USER_HOME/large-files-count.txt ]; then
  echo "$USER_HOME/large-files-count.txt does not exist"
  exit 1
fi

count=$(cat $USER_HOME/large-files-count.txt | tr -d '[:space:]')
if [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Found $count files larger than 1MB in /usr."
  exit 0
else
  echo "File should contain a number, got: '$count'"
  exit 1
fi
