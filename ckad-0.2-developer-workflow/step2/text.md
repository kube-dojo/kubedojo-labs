# Deploy and Iterate on an Application

In the exam, you often need to create something, then modify it. Practice this edit-apply cycle.

## Task

1. Create a deployment named `backend` with image `redis:7` and 1 replica in `dev-workflow` namespace.
2. Scale the deployment to 3 replicas using `kubectl scale`.
3. Update the image to `redis:7.2` using `kubectl set image`.
4. Verify the rollout completed and save the deployment image to `/root/backend-image.txt` using:
   ```
   kubectl get deployment backend -n dev-workflow -o jsonpath='{.spec.template.spec.containers[0].image}'
   ```

## Hint

`kubectl set image deployment/backend redis=redis:7.2 -n dev-workflow` updates the container named `redis`.
