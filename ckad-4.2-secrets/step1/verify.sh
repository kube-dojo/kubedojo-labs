#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get secret db-creds -n secrets-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: Secret db-creds not found"
  exit 1
fi
if [ ! -f $USER_HOME/decoded-password.txt ]; then
  echo "FAIL: $USER_HOME/decoded-password.txt not found"
  exit 1
fi
PASS=$(cat $USER_HOME/decoded-password.txt | tr -d '[:space:]')
if [ "$PASS" != "s3cur3P@ss" ]; then
  echo "FAIL: Decoded password incorrect"
  exit 1
fi
if [ ! -f $USER_HOME/secret-type.txt ]; then
  echo "FAIL: $USER_HOME/secret-type.txt not found"
  exit 1
fi
echo "PASS"
exit 0
