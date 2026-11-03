#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/web-pod-ip.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
IP=$(cat "$FILE")
ACTUAL=$(kubectl get pod web -o jsonpath='{.status.podIP}') || exit 2
if [ -n "$ACTUAL" ] && [ "$IP" = "$ACTUAL" ]; then
  echo "PASS: Pod IP verified!"
  exit 0
else
  echo "FAIL: $FILE must contain the web pod's IP address. Found: $IP"
  exit 1
fi
