## Rolling Update Strategy

Rolling updates allow you to update pods gradually, controlling how many can be unavailable or exceed the desired count during the update.

### Task

1. Create a deployment named `web-deploy` in the `practice` namespace with:
   - Image: `nginx:1.24`
   - Replicas: `3`
   - Strategy: `RollingUpdate` with `maxSurge: 1` and `maxUnavailable: 0`

2. Once the deployment is ready, update the image to `nginx:1.25`:
   ```bash
   kubectl set image deployment/web-deploy nginx=nginx:1.25 -n practice
   ```

3. Watch the rollout:
   ```bash
   kubectl rollout status deployment/web-deploy -n practice
   ```

<details>
<summary>Hint: Deployment strategy spec</summary>

```yaml
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
```

The `maxUnavailable: 0` ensures zero downtime — a new pod must be ready before an old one is terminated.
</details>
