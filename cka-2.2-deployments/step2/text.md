## Deployment History

Every time you update a deployment, Kubernetes records a new revision. You can annotate changes for better traceability.

### Task

Using the `web-deploy` deployment from the previous step:

1. Record the current revision by annotating:
   ```bash
   kubectl annotate deployment/web-deploy -n practice kubernetes.io/change-cause="initial deploy nginx:1.24" --overwrite
   ```

2. Update the image to `nginx:1.25` (if not already done) and annotate:
   ```bash
   kubectl set image deployment/web-deploy nginx=nginx:1.25 -n practice --record=false
   kubectl annotate deployment/web-deploy -n practice kubernetes.io/change-cause="update to nginx:1.25" --overwrite
   ```

3. Update the image to `nginx:1.26` and annotate:
   ```bash
   kubectl set image deployment/web-deploy nginx=nginx:1.26 -n practice
   kubectl annotate deployment/web-deploy -n practice kubernetes.io/change-cause="update to nginx:1.26" --overwrite
   ```

4. Check the rollout history:
   ```bash
   kubectl rollout history deployment/web-deploy -n practice
   ```

You should see **at least 3 revisions**.

<details>
<summary>Hint: Checking revision count</summary>

`kubectl rollout history` lists all revisions. Each `kubectl set image` or `kubectl apply` with changes creates a new revision. Make sure each update has completed before starting the next.
</details>
