#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/ip-forward.txt contains 0 or 1
if [ ! -f $USER_HOME/ip-forward.txt ]; then
  echo "$USER_HOME/ip-forward.txt does not exist"
  exit 1
fi

value=$(cat $USER_HOME/ip-forward.txt | tr -d '[:space:]')
if [ "$value" = "0" ] || [ "$value" = "1" ]; then
  echo "ip_forward = $value"
  exit 0
else
  echo "Expected 0 or 1, got: '$value'"
  exit 1
fi
