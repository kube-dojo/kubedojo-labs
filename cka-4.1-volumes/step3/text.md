## Projected Volumes

Projected volumes combine multiple volume sources (ConfigMaps, Secrets, downward API, and serviceAccountToken) into a single directory.

### Task

Create a pod named `projected-pod` in the `practice` namespace that uses a projected volume to mount:

1. The `app-config` ConfigMap
2. The `app-secret` Secret
3. The downward API field `metadata.labels` as a file named `labels`

Mount everything at `/etc/app-config`.

```bash
# After creating the pod, verify all projected sources
kubectl exec projected-pod -n practice -- ls /etc/app-config
kubectl exec projected-pod -n practice -- cat /etc/app-config/APP_ENV
kubectl exec projected-pod -n practice -- cat /etc/app-config/DB_PASSWORD
kubectl exec projected-pod -n practice -- cat /etc/app-config/labels
```

<details>
<summary>Hint: Projected volume YAML</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: projected-pod
  namespace: practice
  labels:
    app: projected-demo
    env: production
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    volumeMounts:
    - name: all-config
      mountPath: /etc/app-config
  volumes:
  - name: all-config
    projected:
      sources:
      - configMap:
          name: app-config
      - secret:
          name: app-secret
      - downwardAPI:
          items:
          - path: labels
            fieldRef:
              fieldPath: metadata.labels
```
</details>
