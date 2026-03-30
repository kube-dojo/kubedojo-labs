# Create Different Types of Secrets

## Task

1. Create a generic Secret named `db-creds` in `secrets-lab`:
   ```
   kubectl create secret generic db-creds --from-literal=username=admin --from-literal=password=s3cur3P@ss -n secrets-lab
   ```
2. Verify the Secret was created and decode the password:
   ```
   kubectl get secret db-creds -n secrets-lab -o jsonpath='{.data.password}' | base64 -d
   ```
   Save the decoded password to `/root/decoded-password.txt`.
3. Check the Secret type:
   ```
   kubectl get secret db-creds -n secrets-lab -o jsonpath='{.type}'
   ```
   Save to `/root/secret-type.txt`.

## Hint

Secrets are base64-encoded (NOT encrypted). Use `base64 -d` to decode. The type of a generic secret is `Opaque`.
