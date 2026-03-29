## Step 4: Dry Run and Explain

Two commands that save enormous time: `--dry-run=client` and `kubectl explain`.

### Generate a manifest with dry-run

Instead of writing YAML from scratch, let kubectl generate it:

```bash
kubectl run test-pod --image=busybox --dry-run=client -o yaml
```

This creates a valid Pod manifest **without actually creating the pod**. You can redirect it to a file and edit it:

```bash
kubectl run test-pod --image=busybox --command -- sleep 3600 --dry-run=client -o yaml > /tmp/test.yaml
```

This works for many resource types:

```bash
kubectl create deployment test-deploy --image=nginx --dry-run=client -o yaml
```

### Explore the API with explain

What fields does a Pod spec support?

```bash
kubectl explain pod.spec
```

Go deeper:

```bash
kubectl explain pod.spec.containers
```

```bash
kubectl explain pod.spec.containers.ports
```

This is like having the Kubernetes API documentation right in your terminal.

### Your task

Generate a Pod manifest for a pod named `nginx` using the `nginx:1.25` image with `--dry-run=client -o yaml` and save it to:

```
/root/nginx-pod.yaml
```

<details>
<summary>Hint</summary>

```bash
kubectl run nginx --image=nginx:1.25 --dry-run=client -o yaml > /root/nginx-pod.yaml
```
</details>
