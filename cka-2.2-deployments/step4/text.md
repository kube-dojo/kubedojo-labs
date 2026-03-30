## Paused Deployments

Pausing a deployment lets you make multiple changes without triggering a rollout for each one.

### Task

1. Pause the `web-deploy` deployment:
   ```bash
   kubectl rollout pause deployment/web-deploy -n practice
   ```

2. Make multiple changes while paused:
   ```bash
   kubectl set image deployment/web-deploy nginx=nginx:1.27 -n practice
   kubectl set resources deployment/web-deploy -c nginx --limits=cpu=200m,memory=128Mi -n practice
   ```

3. Resume the deployment (all changes roll out together):
   ```bash
   kubectl rollout resume deployment/web-deploy -n practice
   ```

4. Verify the deployment is no longer paused and has rolled out:
   ```bash
   kubectl rollout status deployment/web-deploy -n practice
   ```

<details>
<summary>Hint: Checking pause status</summary>

When paused, `kubectl rollout status` shows "waiting for resume". After resume, it proceeds normally. You can also check the deployment conditions — a paused deployment will not have a progressing condition.
</details>
