#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/cpu-model.txt has content
if [ ! -f $USER_HOME/cpu-model.txt ]; then
  echo "$USER_HOME/cpu-model.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/cpu-model.txt ]; then
  echo "$USER_HOME/cpu-model.txt is empty"
  exit 1
fi

echo "CPU model: $(cat $USER_HOME/cpu-model.txt)"
exit 0
