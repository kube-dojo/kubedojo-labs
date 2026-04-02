## Step 2: Get API Documentation

Kubernetes is built on a massive REST API. `kubectl explain` is your best friend for understanding YAML fields.

### Explain a resource
```bash
kubectl explain pod
```

### Get deep details
```bash
kubectl explain pod.spec.containers --recursive
```

### Your task
Generate a YAML manifest for a simple pod using `nginx:1.25` and save it to `/root/pod-spec.yaml`.

<details>
<summary>Hint</summary>

```bash
kubectl run nginx-pod --image=nginx:1.25 --dry-run=client -o yaml > /root/pod-spec.yaml
```
</details>
