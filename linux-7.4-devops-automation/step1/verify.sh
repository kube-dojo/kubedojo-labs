#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/app.conf ]; then
  echo "FAIL: $USER_HOME/app.conf not found"
  exit 1
fi

if grep -q '${' $USER_HOME/app.conf; then
  echo "FAIL: $USER_HOME/app.conf still contains unresolved \${} placeholders"
  exit 1
fi

echo "PASS: app.conf has no unresolved placeholders"
exit 0
