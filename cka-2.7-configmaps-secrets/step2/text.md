## Mount ConfigMap as Volume

When you mount a ConfigMap as a volume, each key becomes a file in the mount path.

### Task

Create a pod named `config-vol-pod` in the `practice` namespace that:

- Image: `nginx:1.25`
- Mounts the `app-config` ConfigMap as a volume at `/etc/config`

After the pod is running, verify the files exist:

```bash
kubectl exec config-vol-pod -n practice -- cat /etc/config/APP_ENV
```

This should output `production`.

<details>
<summary>Hint: Volume mount for ConfigMap</summary>

```yaml
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
      name: app-config
```
</details>
