# Create TLS Certificates and Kubernetes Secrets

Generate self-signed TLS certificates and store them as Kubernetes secrets for Ingress use.

## Task

1. Generate a self-signed TLS certificate:
   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
     -keyout "$HOME"/tls.key -out "$HOME"/tls.crt \
     -subj "/CN=secure.example.com/O=CKS Lab"
   ```
2. Create a TLS secret named `tls-secret` in the `ingress-lab` namespace from the generated certificate and key.
3. Verify the secret exists and contains `tls.crt` and `tls.key` data. Save the secret type to `"$HOME"/secret-type.txt`.

## Hint

Use `kubectl create secret tls tls-secret --cert="$HOME"/tls.crt --key="$HOME"/tls.key -n ingress-lab`.
