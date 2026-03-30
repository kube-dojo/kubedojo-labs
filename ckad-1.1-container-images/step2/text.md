# Work with Image Tags and Digests

Using specific tags (not `latest`) ensures reproducible deployments. In the exam, you may need to update image tags.

## Task

1. Create a deployment named `pinned-app` with image `httpd:2.4.58` and 2 replicas in `images-lab`.
2. Update the deployment image to `httpd:2.4.59` using `kubectl set image`.
3. Verify the rollout succeeded and save the rollout history to `/root/rollout-history.txt` using:
   ```
   kubectl rollout history deployment/pinned-app -n images-lab
   ```

## Hint

Use `kubectl set image deployment/pinned-app httpd=httpd:2.4.59 -n images-lab` to update.
