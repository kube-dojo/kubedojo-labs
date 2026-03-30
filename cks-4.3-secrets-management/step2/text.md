# Configure Encryption at Rest for Secrets

Enable encryption at rest to protect secrets stored in etcd.

## Task

1. Generate an encryption key: `head -c 32 /dev/urandom | base64` and save to `/root/encryption-key.txt`.
2. Create an EncryptionConfiguration at `/etc/kubernetes/enc/encryption-config.yaml`:
   ```yaml
   apiVersion: apiserver.config.k8s.io/v1
   kind: EncryptionConfiguration
   resources:
     - resources:
         - secrets
       providers:
         - aescbc:
             keys:
               - name: key1
                 secret: <your-base64-key>
         - identity: {}
   ```
3. The `identity` provider as fallback allows reading existing unencrypted secrets.
4. Save the EncryptionConfiguration to `/root/encryption-config.yaml` (copy, do not apply to API server in this lab to avoid disruption).

## Hint

The `identity` provider must be listed LAST — it allows reading unencrypted data. `aescbc` encrypts new secrets. To apply, add `--encryption-provider-config` to the API server manifest.
