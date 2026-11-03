#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/cp-pod-count.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
COUNT=$(cat "$FILE")
ACTUAL=$(kubectl get pods -n kube-system -o json | python3 -c 'import json,sys; print(len(json.load(sys.stdin)["items"]))') || exit 2
if [[ "$COUNT" =~ ^[0-9]+$ ]] && [ "$COUNT" = "$ACTUAL" ]; then
  echo "PASS: Pod count verified!"
  exit 0
else
  echo "FAIL: Incorrect count in $FILE. Expected $ACTUAL."
  exit 1
fi
