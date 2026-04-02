#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/deploy-short.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(cat "$FILE" | tr -d '[:space:]')
if [ "$CONTENT" = "deploy" ]; then
  echo "PASS: deploy-short.txt contains the correct short name"
  exit 0
else
  echo "FAIL: expected 'deploy', got: '$CONTENT'"
  exit 1
fi