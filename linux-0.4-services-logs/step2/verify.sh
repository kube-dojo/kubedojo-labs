#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/nginx-journal.txt exists and has content
if [ ! -f $USER_HOME/nginx-journal.txt ]; then
  echo "$USER_HOME/nginx-journal.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/nginx-journal.txt ]; then
  echo "$USER_HOME/nginx-journal.txt is empty"
  exit 1
fi

echo "Journal output captured!"
exit 0
