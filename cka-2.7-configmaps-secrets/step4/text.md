## Environment Variables from ConfigMap/Secret

Instead of mounting as volumes, you can inject ConfigMap and Secret values directly as environment variables using `envFrom`.

### Task

Create a pod named `env-pod` in the `practice` namespace that:

- Image: `nginx:1.25`
- Uses `envFrom` to load **all** keys from the `app-config` ConfigMap as environment variables

Verify:

```bash
kubectl exec env-pod -n practice -- env | grep -E "APP_ENV|LOG_LEVEL"
```

You should see:
```
APP_ENV=production
LOG_LEVEL=info
```

<details>
<summary>Hint: envFrom spec</summary>

```yaml
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    envFrom:
    - configMapRef:
        name: app-config
```

You can also mix ConfigMap and Secret references:
```yaml
    envFrom:
    - configMapRef:
        name: app-config
    - secretRef:
        name: db-creds
```
</details>
