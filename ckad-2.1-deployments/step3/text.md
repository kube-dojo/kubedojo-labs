# Rollbacks and Revision History

## Task

1. View the rollout history of `webapp`: `kubectl rollout history deployment/webapp -n deploy-lab`.
2. Roll back to the previous revision: `kubectl rollout undo deployment/webapp -n deploy-lab`.
3. Verify the image is back to `nginx:1.24`.
4. Save the current image to `/root/rollback-image.txt`.

## Hint

`kubectl rollout undo` reverts to the previous revision. Use `kubectl rollout undo deployment/webapp --to-revision=N` for a specific revision.
