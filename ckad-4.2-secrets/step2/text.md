# Use Secrets as Environment Variables

## Task

1. Create a pod named `secret-env-pod` in `secrets-lab` with image `busybox:1.36` and command `sleep 3600` that:
   - Sets env var `DB_USER` from Secret `db-creds` key `username`
   - Sets env var `DB_PASS` from Secret `db-creds` key `password`
2. Verify the env vars inside the pod:
   ```
   kubectl exec secret-env-pod -n secrets-lab -- printenv DB_USER
   ```
3. Save the DB_USER value to `/root/db-user.txt`.

## Hint

Use `valueFrom.secretKeyRef` with `name` and `key` fields to reference individual Secret keys.
