#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/cp-health.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

S_RUNNING=$(grep "scheduler" "$FILE" | grep -i "Running" | wc -l)
C_RUNNING=$(grep "controller-manager" "$FILE" | grep -i "Running" | wc -l)

if [ "$S_RUNNING" -ge 1 ] && [ "$C_RUNNING" -ge 1 ]; then
  echo "PASS: Scheduler and Controller Manager are confirmed Running"
  exit 0
else
  echo "FAIL: File must show both scheduler and controller-manager in Running state"
  exit 1
fi