#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/port-check.txt contains "open" or "succeeded"
if [ ! -f $USER_HOME/port-check.txt ]; then
  echo "$USER_HOME/port-check.txt does not exist"
  exit 1
fi

content=$(cat $USER_HOME/port-check.txt)
if echo "$content" | grep -qiE "(open|succeeded|connected)"; then
  echo "Port check passed!"
  exit 0
else
  echo "File should contain 'open' or 'succeeded', got: '$content'"
  exit 1
fi
