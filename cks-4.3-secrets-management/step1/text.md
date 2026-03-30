# Create and Manage Kubernetes Secrets Securely

Understand the different types of secrets and how they are stored.

## Task

1. Create a generic secret named `app-secret` in `secrets-lab` with key `password=S3cur3P@ss!`.
2. Create a TLS secret named `tls-secret` in `secrets-lab` (generate a self-signed cert first).
3. Create a docker-registry secret named `registry-secret` in `secrets-lab` with dummy credentials.
4. Examine how secrets are stored by reading the raw etcd data. Use:
   ```bash
   ETCDCTL_API=3 etcdctl get /registry/secrets/secrets-lab/app-secret \
     --endpoints=https://127.0.0.1:2379 \
     --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt \
     --key=/etc/kubernetes/pki/etcd/server.key | hexdump -C | head -20
   ```
   Save the output to `/root/etcd-secret-raw.txt`.

## Hint

Secrets in etcd are base64-encoded but NOT encrypted by default. The hexdump should show the secret data in readable form.
