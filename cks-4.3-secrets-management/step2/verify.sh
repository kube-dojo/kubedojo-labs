#!/bin/bash
if [ ! -f /root/encryption-key.txt ] || [ ! -s /root/encryption-key.txt ]; then
  echo "FAIL: /root/encryption-key.txt missing or empty"
  exit 1
fi
if [ ! -f /root/encryption-config.yaml ] || [ ! -s /root/encryption-config.yaml ]; then
  echo "FAIL: /root/encryption-config.yaml missing or empty"
  exit 1
fi
if ! grep -q "EncryptionConfiguration" /root/encryption-config.yaml; then
  echo "FAIL: Missing EncryptionConfiguration kind"
  exit 1
fi
if ! grep -q "aescbc" /root/encryption-config.yaml; then
  echo "FAIL: Missing aescbc provider"
  exit 1
fi
echo "PASS"
exit 0
