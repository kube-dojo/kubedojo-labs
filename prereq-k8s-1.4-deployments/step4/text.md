## Step 4: Rollback a Deployment

Things go wrong. A bad image, a broken config — rollbacks let you revert instantly.

### Check rollout history

```bash
kubectl rollout history deployment/webapp
```

### Undo the last update

```bash
kubectl rollout undo deployment/webapp
```

This reverts to the previous revision. Kubernetes creates new pods with the old image and terminates the new ones.

### Watch it happen

```bash
kubectl rollout status deployment/webapp
```

### Verify the rollback

```bash
kubectl describe deployment webapp | grep "Image:"
```

You should see `nginx:1.25` again.

### Your task

Roll back the `webapp` deployment to the previous version so it's running `nginx:1.25` again.

<details>
<summary>Hint</summary>

```bash
kubectl rollout undo deployment/webapp
kubectl rollout status deployment/webapp
```

Verify:

```bash
kubectl describe deployment webapp | grep "Image:"
```

Should show `nginx:1.25`.
</details>
