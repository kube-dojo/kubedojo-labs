#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/cert-expiry.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -qi "CERTIFICATE" "$FILE" && grep -qi "EXPIRES" "$FILE"; then
  echo "PASS: Certificate expiration report verified"
  exit 0
else
  echo "FAIL: File does not appear to be a valid 'kubeadm certs check-expiration' output"
  exit 1
fi