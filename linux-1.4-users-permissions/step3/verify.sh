#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/sudo-rule.txt contains developer and apt
if [ ! -f $USER_HOME/sudo-rule.txt ]; then
  echo "$USER_HOME/sudo-rule.txt does not exist"
  exit 1
fi

content=$(cat $USER_HOME/sudo-rule.txt)
if echo "$content" | grep -q "developer" && echo "$content" | grep -q "apt"; then
  echo "Sudo rule: $content"
  exit 0
else
  echo "File should contain 'developer' and 'apt', got: '$content'"
  exit 1
fi
