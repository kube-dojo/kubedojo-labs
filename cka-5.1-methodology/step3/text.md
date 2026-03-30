## Comprehensive Diagnosis Exercise

The `webapp` deployment was working but is now failing after an image update. Apply systematic troubleshooting to fix it.

### Task

1. Check the deployment status and identify the problem
2. Check the rollout history to find the last working configuration
3. Roll back to the working version

```bash
# Step 1: Check deployment
kubectl get deployment webapp -n practice
kubectl rollout status deployment/webapp -n practice

# Step 2: Check pods
kubectl get pods -n practice -l app=webapp

# Step 3: Describe a failing pod
kubectl describe pod -n practice -l app=webapp | grep -A5 "Events:" | tail -20

# Step 4: Check rollout history
kubectl rollout history deployment/webapp -n practice

# Step 5: Rollback
kubectl rollout undo deployment/webapp -n practice
kubectl rollout status deployment/webapp -n practice
```

<details>
<summary>Hint: Deployment rollback</summary>

```bash
# Quick rollback to previous version
kubectl rollout undo deployment/webapp -n practice

# Or rollback to specific revision
kubectl rollout undo deployment/webapp -n practice --to-revision=1

# Verify
kubectl rollout status deployment/webapp -n practice
kubectl get pods -n practice -l app=webapp
```
</details>
