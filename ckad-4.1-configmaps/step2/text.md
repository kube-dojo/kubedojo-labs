# Use ConfigMaps as Environment Variables

## Task

1. Create a pod named `env-pod` in `cm-lab` with image `busybox:1.36` and command `sh -c "env | sort; sleep 3600"` that:
   - Loads ALL keys from `app-config` ConfigMap as environment variables using `envFrom`.
2. After the pod is running, verify the env vars:
   ```
   kubectl exec env-pod -n cm-lab -- env | grep APP_ENV
   ```
3. Save the value of `APP_ENV` to `/root/app-env-value.txt`.

## Hint

Use `envFrom` with `configMapRef` to load all keys from a ConfigMap as environment variables.
