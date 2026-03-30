# Mount ConfigMaps as Volumes

## Task

1. Create a pod named `vol-pod` in `cm-lab` with image `busybox:1.36` and command `sleep 3600` that:
   - Mounts the `file-config` ConfigMap as a volume at `/etc/config`
2. After the pod is running, verify the file exists:
   ```
   kubectl exec vol-pod -n cm-lab -- cat /etc/config/app.properties
   ```
3. Save the contents of the mounted file to `/root/mounted-config.txt`.

## Hint

Use a volume of type `configMap` with `name: file-config` and mount it at `/etc/config`.
