#!/bin/bash
KEY=$(head -c 32 /dev/urandom | base64)
echo "$KEY" > /root/encryption-key.txt

mkdir -p /etc/kubernetes/enc 2>/dev/null || true

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

# Try to copy to the expected location
cp /root/encryption-config.yaml /etc/kubernetes/enc/encryption-config.yaml 2>/dev/null || true

# In kind, also try to copy to the node
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
if [ -n "$NODE" ]; then
  docker exec "$NODE" mkdir -p /etc/kubernetes/enc 2>/dev/null
  docker cp /root/encryption-config.yaml "$NODE:/etc/kubernetes/enc/encryption-config.yaml" 2>/dev/null
fi
