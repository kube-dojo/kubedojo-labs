## Secrets

Secrets store sensitive data like passwords and tokens. They are base64-encoded (not encrypted) by default.

### Task

1. Create a Secret named `db-creds` in the `practice` namespace with:
   - `username=admin`
   - `password=s3cur3P@ss`

   ```bash
   kubectl create secret generic db-creds \
     --from-literal=username=admin \
     --from-literal=password='s3cur3P@ss' \
     -n practice
   ```

2. Create a pod named `secret-pod` in the `practice` namespace that mounts the Secret as a volume at `/etc/secrets`:
   - Image: `nginx:1.25`

3. Verify the pod can read the secret values:
   ```bash
   kubectl exec secret-pod -n practice -- cat /etc/secrets/username
   kubectl exec secret-pod -n practice -- cat /etc/secrets/password
   ```

<details>
<summary>Hint: Secret volume mount</summary>

```yaml
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secrets
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: db-creds
```
</details>
