#!/bin/bash
KEY=$(head -c 32 /dev/urandom | base64)
echo "$KEY" > /root/encryption-key.txt

mkdir -p /etc/kubernetes/enc
cat > /root/encryption-config.yaml << YAML
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: $KEY
      - identity: {}
YAML
cp /root/encryption-config.yaml /etc/kubernetes/enc/encryption-config.yaml
