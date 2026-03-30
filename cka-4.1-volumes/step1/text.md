## emptyDir Volumes

An `emptyDir` volume is created when a pod is assigned to a node and is deleted when the pod is removed. It provides temporary scratch space and is commonly used to share data between containers in the same pod.

### Task

Create a pod named `cache-pod` in the `practice` namespace with:

1. A shared `emptyDir` volume named `cache-vol` with a **100Mi** size limit
2. A `writer` container (image: `busybox:1.36`) that writes the current timestamp to `/cache/data.txt` every 3 seconds
3. A `reader` container (image: `busybox:1.36`) that reads `/cache/data.txt` every 5 seconds

Both containers should mount `cache-vol` at `/cache`.

```bash
# After creating the pod, verify data sharing
kubectl exec cache-pod -n practice -c reader -- cat /cache/data.txt
```

<details>
<summary>Hint: emptyDir with sizeLimit</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cache-pod
  namespace: practice
spec:
  containers:
  - name: writer
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do date > /cache/data.txt; sleep 3; done"]
    volumeMounts:
    - name: cache-vol
      mountPath: /cache
  - name: reader
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do cat /cache/data.txt; sleep 5; done"]
    volumeMounts:
    - name: cache-vol
      mountPath: /cache
  volumes:
  - name: cache-vol
    emptyDir:
      sizeLimit: 100Mi
```
</details>
