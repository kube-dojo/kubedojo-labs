#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/etcd-endpoint.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -qE "https?://[0-9.]+:(2379|4001)" "$FILE"; then
  echo "PASS: etcd endpoint verified"
  exit 0
else
  echo "FAIL: File should contain a valid etcd endpoint URL (e.g., https://127.0.0.1:2379)"
  exit 1
fi