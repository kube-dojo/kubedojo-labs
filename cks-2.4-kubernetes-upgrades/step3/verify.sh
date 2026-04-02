#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in node-status.txt system-pods.txt app-status.txt component-status.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
