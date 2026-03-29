## Step 3: Update a Deployment

When you update the container image, Kubernetes performs a **rolling update** — replacing pods one at a time so there's no downtime.

### Check current image

```bash
kubectl describe deployment webapp | grep "Image:"
```

You should see `nginx:1.25`.

### Update the image

```bash
kubectl set image deployment/webapp nginx=nginx:1.26
```

The format is: `kubectl set image deployment/<name> <container-name>=<new-image>`.

### Watch the rollout

```bash
kubectl rollout status deployment/webapp
```

This blocks until the update is complete.

### Check rollout history

```bash
kubectl rollout history deployment/webapp
```

You should see two revisions.

### Verify the new image

```bash
kubectl describe deployment webapp | grep "Image:"
```

### Your task

The deployment should already be updated from the examples above. Verify that the `webapp` deployment is using `nginx:1.26`.

If you skipped the example commands, update it now:

```bash
kubectl set image deployment/webapp nginx=nginx:1.26
```

<details>
<summary>Hint</summary>

```bash
kubectl set image deployment/webapp nginx=nginx:1.26
kubectl rollout status deployment/webapp
```

Verify:

```bash
kubectl describe deployment webapp | grep "Image:"
```
</details>
