#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/node-name.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
NODE_NAME=$(cat "$FILE" | tr -d '[:space:]')
if [ -z "$NODE_NAME" ]; then
  echo "FAIL: $FILE is empty."
  exit 1
fi
if kubectl get node "$NODE_NAME" > /dev/null 2>&1; then
  echo "PASS: Node name verified!"
  exit 0
else
  echo "FAIL: Node '$NODE_NAME' not found in cluster."
  exit 1
fi
