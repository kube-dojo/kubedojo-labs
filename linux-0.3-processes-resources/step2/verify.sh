#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/bg-pid.txt exists and the process is no longer running
if [ ! -f $USER_HOME/bg-pid.txt ]; then
  echo "$USER_HOME/bg-pid.txt does not exist"
  exit 1
fi

pid=$(cat $USER_HOME/bg-pid.txt | tr -d '[:space:]')
if ! [[ "$pid" =~ ^[0-9]+$ ]]; then
  echo "File should contain a PID number, got: '$pid'"
  exit 1
fi

# Check that the process is no longer running
if kill -0 "$pid" 2>/dev/null; then
  echo "Process $pid is still running — you need to kill it"
  exit 1
fi

echo "Process $pid was started and killed. Well done!"
exit 0
