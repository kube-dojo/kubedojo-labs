#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/encryption-key.txt ] || [ ! -s $USER_HOME/encryption-key.txt ]; then
  echo "FAIL: $USER_HOME/encryption-key.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/encryption-config.yaml ] || [ ! -s $USER_HOME/encryption-config.yaml ]; then
  echo "FAIL: $USER_HOME/encryption-config.yaml missing or empty"
  exit 1
fi
if ! grep -q "EncryptionConfiguration" $USER_HOME/encryption-config.yaml; then
  echo "FAIL: Missing EncryptionConfiguration kind"
  exit 1
fi
if ! grep -q "aescbc" $USER_HOME/encryption-config.yaml; then
  echo "FAIL: Missing aescbc provider"
  exit 1
fi
echo "PASS"
exit 0
