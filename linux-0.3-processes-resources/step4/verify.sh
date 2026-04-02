#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/nofile-limit.txt contains a number
if [ ! -f $USER_HOME/nofile-limit.txt ]; then
  echo "$USER_HOME/nofile-limit.txt does not exist"
  exit 1
fi

content=$(cat $USER_HOME/nofile-limit.txt | tr -d '[:space:]')
if [[ "$content" =~ ^[0-9]+$ ]]; then
  echo "Open files limit: $content"
  exit 0
else
  echo "File should contain a number, got: '$content'"
  exit 1
fi
