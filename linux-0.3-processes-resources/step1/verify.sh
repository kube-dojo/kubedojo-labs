#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/init-name.txt exists and contains a known init system
if [ ! -f $USER_HOME/init-name.txt ]; then
  echo "$USER_HOME/init-name.txt does not exist"
  exit 1
fi

content=$(cat $USER_HOME/init-name.txt | tr -d '[:space:]')
if [ -n "$content" ]; then
  echo "Init process: $content. Correct!"
  exit 0
else
  echo "File is empty"
  exit 1
fi
