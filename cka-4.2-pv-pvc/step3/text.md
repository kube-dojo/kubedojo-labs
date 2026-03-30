## Use PVCs in Pods

Once a PVC is bound, pods can reference it in their volume definitions to persist data.

### Task

Create a pod named `pvc-pod` in the `practice` namespace that:

1. Uses image `nginx:1.25`
2. Mounts `pvc-app` at `/usr/share/nginx/html`
3. Writes a test file to verify persistence

```bash
# After creating the pod, write data
kubectl exec pvc-pod -n practice -- bash -c 'echo "Persistent data!" > /usr/share/nginx/html/test.txt'

# Delete and recreate the pod to verify persistence
kubectl delete pod pvc-pod -n practice
# Recreate the same pod (apply again)
# Check if data persists
kubectl exec pvc-pod -n practice -- cat /usr/share/nginx/html/test.txt
```

<details>
<summary>Hint: Pod with PVC</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pvc-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: app-storage
      mountPath: /usr/share/nginx/html
  volumes:
  - name: app-storage
    persistentVolumeClaim:
      claimName: pvc-app
```
</details>
