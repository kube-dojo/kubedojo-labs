#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/nginx-chart.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(cat "$FILE" | tr -d '[:space:]')
if [ "$CONTENT" = "bitnami/nginx" ]; then
  echo "PASS: bitnami/nginx repo found and saved"
  exit 0
else
  echo "FAIL: expected 'bitnami/nginx', got: '$CONTENT'"
  exit 1
fi