#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/fhs-quiz.txt has entries for /etc, /var, /tmp
if [ ! -f $USER_HOME/fhs-quiz.txt ]; then
  echo "$USER_HOME/fhs-quiz.txt does not exist"
  exit 1
fi

missing=""
for dir in "/etc" "/var" "/tmp"; do
  if ! grep -q "$dir" $USER_HOME/fhs-quiz.txt; then
    missing="$missing $dir"
  fi
done

if [ -z "$missing" ]; then
  echo "All required entries found!"
  exit 0
else
  echo "Missing entries for:$missing"
  exit 1
fi
