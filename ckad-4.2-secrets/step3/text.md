# Mount Secrets as Volumes

## Task

1. Create a pod named `secret-vol-pod` in `secrets-lab` with image `busybox:1.36` and command `sleep 3600` that:
   - Mounts the `db-creds` Secret as a volume at `/etc/secrets`
2. Verify the files exist:
   ```
   kubectl exec secret-vol-pod -n secrets-lab -- ls /etc/secrets/
   kubectl exec secret-vol-pod -n secrets-lab -- cat /etc/secrets/username
   ```
3. Save the username from the mounted file to `/root/mounted-username.txt`.

## Hint

Use a volume of type `secret` with `secretName: db-creds`. Each key becomes a file in the mount path.
