## Rollback to Specific Revision

When a deployment update causes issues, you can rollback to any previous revision.

### Task

1. Check the current image version:
   ```bash
   kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.template.spec.containers[0].image}'
   ```

2. Rollback `web-deploy` to **revision 1** (the original `nginx:1.24`):
   ```bash
   kubectl rollout undo deployment/web-deploy -n practice --to-revision=1
   ```

3. Verify the image is back to `nginx:1.24`:
   ```bash
   kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.template.spec.containers[0].image}'
   ```

<details>
<summary>Hint: Inspecting a specific revision</summary>

Use `kubectl rollout history deployment/web-deploy -n practice --revision=1` to see what image was used in revision 1 before rolling back.
</details>
