# Certificate Management

Kubernetes uses TLS certificates for secure communication between components. kubeadm manages these certificates and can check their expiration.

**Key commands:**
```bash
kubeadm certs check-expiration    # Show expiration dates for all certs
kubeadm certs renew all           # Renew all certificates
```

Certificates are stored in `/etc/kubernetes/pki/`.

## Task

Run `kubeadm certs check-expiration` and save the output to `/root/cert-expiry.txt`.

<details>
<summary>Hint</summary>

```bash
kubeadm certs check-expiration > /root/cert-expiry.txt 2>&1
```
</details>