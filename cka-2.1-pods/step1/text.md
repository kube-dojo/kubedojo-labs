## Multi-container Pods

The sidecar pattern is one of the most common multi-container patterns. In this step, you will create a pod with two containers that share a volume:

- **nginx** — serves files from a shared volume
- **busybox sidecar** — writes the current date to a file every 5 seconds

### Task

Create a pod named `sidecar-pod` in the `practice` namespace with:

1. A shared `emptyDir` volume named `shared-data`
2. An `nginx` container (image: `nginx:1.25`) that mounts the volume at `/usr/share/nginx/html`
3. A `sidecar` container (image: `busybox:1.36`) that mounts the volume at `/data` and runs:
   ```
   while true; do date > /data/index.html; sleep 5; done
   ```

```bash
# Start by generating a base pod YAML
kubectl run sidecar-pod --image=nginx:1.25 --namespace=practice --dry-run=client -o yaml > /root/sidecar-pod.yaml
```

Edit the YAML to add the second container and shared volume, then apply it.

<details>
<summary>Hint: Pod YAML structure</summary>

A multi-container pod has multiple entries in `spec.containers[]`. Both containers reference the same volume name in their `volumeMounts`. The volume is defined in `spec.volumes[]` as `emptyDir: {}`.

```yaml
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: shared-data
      mountPath: /usr/share/nginx/html
  - name: sidecar
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do date > /data/index.html; sleep 5; done"]
    volumeMounts:
    - name: shared-data
      mountPath: /data
  volumes:
  - name: shared-data
    emptyDir: {}
```
</details>
