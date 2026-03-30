## Manual Scaling

Sometimes you need to scale deployments manually, either for testing or immediate capacity changes.

### Task

1. Scale the `scale-app` deployment to **4 replicas**:
   ```bash
   kubectl scale deployment scale-app -n practice --replicas=4
   ```

2. Wait for all replicas to be ready:
   ```bash
   kubectl rollout status deployment/scale-app -n practice
   ```

3. Verify 4 replicas are running:
   ```bash
   kubectl get deployment scale-app -n practice
   kubectl get pods -n practice -l app=scale-app
   ```

<details>
<summary>Hint: Scaling considerations</summary>

When you manually scale a deployment that has an HPA, the HPA may override your manual scaling after its next evaluation cycle. To prevent this, either:
- Delete the HPA first
- Set the HPA min replicas to your desired count

For this exercise, the HPA will not scale down below 1 and the manual scale to 4 will persist since CPU usage is low.
</details>
