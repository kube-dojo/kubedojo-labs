#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/upgrade-plan.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -q "COMPONENT" "$FILE" && grep -q "CURRENT" "$FILE"; then
  echo "PASS: Upgrade plan verified"
  exit 0
else
  echo "FAIL: File does not appear to be a valid 'kubeadm upgrade plan' output"
  exit 1
fi