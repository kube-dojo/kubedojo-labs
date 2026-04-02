#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/cgroup-controllers.txt exists and mentions cpu or memory
if [ ! -f $USER_HOME/cgroup-controllers.txt ]; then
  echo "$USER_HOME/cgroup-controllers.txt does not exist"
  exit 1
fi

if grep -qiE "(cpu|memory)" $USER_HOME/cgroup-controllers.txt; then
  echo "Cgroup controllers: $(cat $USER_HOME/cgroup-controllers.txt)"
  exit 0
else
  echo "Expected to find 'cpu' or 'memory' in cgroup controllers"
  exit 1
fi
