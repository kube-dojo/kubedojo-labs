#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/node-ip.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
IP=$(cat "$FILE")
NODE=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}') || exit 1
INTERNAL_IP=$(kubectl get node "$NODE" -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}') || exit 1
if [ -n "$INTERNAL_IP" ] && [ "$IP" = "$INTERNAL_IP" ]; then
  echo "PASS: Node internal IP verified!"
  exit 0
else
  echo "FAIL: $FILE does not contain the node's InternalIP. Found: $IP"
  exit 1
fi
