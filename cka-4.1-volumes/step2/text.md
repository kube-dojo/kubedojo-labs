## hostPath Volumes

A `hostPath` volume mounts a file or directory from the host node's filesystem into a pod. This is useful for accessing node-level data but ties pods to specific nodes.

### Task

Create a pod named `hostpath-pod` in the `practice` namespace that:

1. Mounts the host directory `/data/hostpath-test` to `/usr/share/nginx/html` in the container
2. Uses the `nginx:1.25` image
3. Uses volume type `DirectoryOrCreate`

```bash
# After creating the pod, verify the host content is accessible
kubectl exec hostpath-pod -n practice -- cat /usr/share/nginx/html/index.html
# Should show: "Hello from the host!"
```

<details>
<summary>Hint: hostPath volume YAML</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: host-data
      mountPath: /usr/share/nginx/html
  volumes:
  - name: host-data
    hostPath:
      path: /data/hostpath-test
      type: DirectoryOrCreate
```
</details>
